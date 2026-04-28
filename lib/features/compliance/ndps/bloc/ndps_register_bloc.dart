import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/compliance_models.dart';
import '../../repository/compliance_repository.dart';

enum NdpsStatus { initial, loading, loaded, success, error }

class NdpsRegisterState extends Equatable {
  const NdpsRegisterState({
    required this.status,
    required this.records,
    this.message,
    this.error,
  });

  const NdpsRegisterState.initial()
      : status = NdpsStatus.initial,
        records = const [],
        message = null,
        error = null;

  final NdpsStatus status;
  final List<NdpsRecord> records;
  final String? message;
  final String? error;

  NdpsRegisterState copyWith({
    NdpsStatus? status,
    List<NdpsRecord>? records,
    String? message,
    String? error,
  }) {
    return NdpsRegisterState(
      status: status ?? this.status,
      records: records ?? this.records,
      message: message,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, records, message, error];
}

sealed class NdpsRegisterEvent extends Equatable {
  const NdpsRegisterEvent();

  @override
  List<Object?> get props => [];
}

class NdpsRegisterLoaded extends NdpsRegisterEvent {
  const NdpsRegisterLoaded();
}

class NdpsRegisterEntrySaved extends NdpsRegisterEvent {
  const NdpsRegisterEntrySaved({
    required this.formType,
    required this.drugName,
    required this.invoiceNo,
    required this.openingQty,
    required this.receivedQty,
    required this.dispensedQty,
    required this.patientName,
    required this.notes,
  });

  final String formType;
  final String drugName;
  final String invoiceNo;
  final double openingQty;
  final double receivedQty;
  final double dispensedQty;
  final String patientName;
  final String notes;

  @override
  List<Object?> get props => [
        formType,
        drugName,
        invoiceNo,
        openingQty,
        receivedQty,
        dispensedQty,
        patientName,
        notes,
      ];
}

class NdpsRegisterBloc extends Bloc<NdpsRegisterEvent, NdpsRegisterState> {
  NdpsRegisterBloc({ComplianceRepository? repository})
      : _repository = repository ?? ComplianceRepository(),
        super(const NdpsRegisterState.initial()) {
    on<NdpsRegisterLoaded>(_onLoaded);
    on<NdpsRegisterEntrySaved>(_onSaved);
  }

  final ComplianceRepository _repository;

  Future<void> _onLoaded(NdpsRegisterLoaded event, Emitter<NdpsRegisterState> emit) async {
    emit(state.copyWith(status: NdpsStatus.loading, error: null, message: null));
    try {
      final records = await _repository.loadNdpsRecords();
      emit(state.copyWith(status: NdpsStatus.loaded, records: records, error: null, message: null));
    } catch (_) {
      emit(state.copyWith(status: NdpsStatus.error, error: 'Unable to load NDPS register entries.', message: null));
    }
  }

  Future<void> _onSaved(NdpsRegisterEntrySaved event, Emitter<NdpsRegisterState> emit) async {
    if (event.formType.trim().isEmpty || event.drugName.trim().isEmpty || event.invoiceNo.trim().isEmpty) {
      emit(
        state.copyWith(
          status: NdpsStatus.error,
          error: 'Form type, invoice number, and drug name are mandatory.',
          message: null,
        ),
      );
      return;
    }

    final closing = ((event.openingQty + event.receivedQty - event.dispensedQty) * 100).round() / 100;
    final record = NdpsRecord(
      formType: event.formType.trim().toUpperCase(),
      drugName: event.drugName.trim(),
      invoiceNo: event.invoiceNo.trim(),
      openingQty: event.openingQty,
      receivedQty: event.receivedQty,
      dispensedQty: event.dispensedQty,
      closingQty: closing,
      patientName: event.patientName.trim().isEmpty ? null : event.patientName.trim(),
      notes: event.notes.trim().isEmpty ? null : event.notes.trim(),
      recordDate: DateTime.now(),
      retentionUntil: DateTime.now().add(const Duration(days: 365 * 2)),
    );

    await _repository.saveNdpsRecord(record, actor: 'system');
    add(const NdpsRegisterLoaded());
    emit(state.copyWith(status: NdpsStatus.success, message: 'NDPS ${record.formType} entry saved.', error: null));
  }
}
