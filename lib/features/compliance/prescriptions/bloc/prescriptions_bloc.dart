import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/compliance_models.dart';
import '../../repository/compliance_repository.dart';

enum PrescriptionsStatus { initial, loading, loaded, success, error }

class PrescriptionsState extends Equatable {
  const PrescriptionsState({
    required this.status,
    required this.records,
    this.message,
    this.error,
  });

  const PrescriptionsState.initial()
      : status = PrescriptionsStatus.initial,
        records = const [],
        message = null,
        error = null;

  final PrescriptionsStatus status;
  final List<PrescriptionRecord> records;
  final String? message;
  final String? error;

  PrescriptionsState copyWith({
    PrescriptionsStatus? status,
    List<PrescriptionRecord>? records,
    String? message,
    String? error,
  }) {
    return PrescriptionsState(
      status: status ?? this.status,
      records: records ?? this.records,
      message: message,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, records, message, error];
}

sealed class PrescriptionsEvent extends Equatable {
  const PrescriptionsEvent();

  @override
  List<Object?> get props => [];
}

class PrescriptionsLoaded extends PrescriptionsEvent {
  const PrescriptionsLoaded();
}

class PrescriptionSaved extends PrescriptionsEvent {
  const PrescriptionSaved({
    required this.invoiceNo,
    required this.patientName,
    required this.doctorName,
    required this.filePath,
  });

  final String invoiceNo;
  final String patientName;
  final String doctorName;
  final String filePath;

  @override
  List<Object?> get props => [invoiceNo, patientName, doctorName, filePath];
}

class PrescriptionsBloc extends Bloc<PrescriptionsEvent, PrescriptionsState> {
  PrescriptionsBloc({ComplianceRepository? repository})
      : _repository = repository ?? ComplianceRepository(),
        super(const PrescriptionsState.initial()) {
    on<PrescriptionsLoaded>(_onLoaded);
    on<PrescriptionSaved>(_onSaved);
  }

  final ComplianceRepository _repository;

  Future<void> _onLoaded(PrescriptionsLoaded event, Emitter<PrescriptionsState> emit) async {
    emit(state.copyWith(status: PrescriptionsStatus.loading, error: null, message: null));
    try {
      final records = await _repository.loadPrescriptionRecords();
      emit(state.copyWith(status: PrescriptionsStatus.loaded, records: records, error: null, message: null));
    } catch (_) {
      emit(state.copyWith(status: PrescriptionsStatus.error, error: 'Unable to load prescriptions.', message: null));
    }
  }

  Future<void> _onSaved(PrescriptionSaved event, Emitter<PrescriptionsState> emit) async {
    if (event.invoiceNo.trim().isEmpty ||
        event.patientName.trim().isEmpty ||
        event.doctorName.trim().isEmpty ||
        event.filePath.trim().isEmpty) {
      emit(
        state.copyWith(
          status: PrescriptionsStatus.error,
          error: 'Invoice, patient, doctor, and file path are mandatory.',
          message: null,
        ),
      );
      return;
    }

    final filePath = event.filePath.trim();
    final isSupported = filePath.toLowerCase().endsWith('.pdf') ||
        filePath.toLowerCase().endsWith('.jpg') ||
        filePath.toLowerCase().endsWith('.jpeg') ||
        filePath.toLowerCase().endsWith('.png');

    if (!isSupported) {
      emit(
        state.copyWith(
          status: PrescriptionsStatus.error,
          error: 'Only PDF or image file paths are allowed (.pdf/.jpg/.jpeg/.png).',
          message: null,
        ),
      );
      return;
    }

    final record = PrescriptionRecord(
      invoiceNo: event.invoiceNo.trim(),
      patientName: event.patientName.trim(),
      doctorName: event.doctorName.trim(),
      filePath: filePath,
      uploadedAt: DateTime.now(),
    );

    await _repository.savePrescriptionRecord(record, actor: 'system');
    add(const PrescriptionsLoaded());
    emit(
      state.copyWith(
        status: PrescriptionsStatus.success,
        message: 'Prescription linked to invoice ${event.invoiceNo}.',
        error: null,
      ),
    );
  }
}
