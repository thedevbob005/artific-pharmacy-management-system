import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/compliance_models.dart';
import '../../repository/compliance_repository.dart';

enum H1Status { initial, loading, loaded, success, error }

class H1RegisterState extends Equatable {
  const H1RegisterState({
    required this.status,
    required this.records,
    this.message,
    this.error,
  });

  const H1RegisterState.initial()
      : status = H1Status.initial,
        records = const [],
        message = null,
        error = null;

  final H1Status status;
  final List<H1Record> records;
  final String? message;
  final String? error;

  H1RegisterState copyWith({
    H1Status? status,
    List<H1Record>? records,
    String? message,
    String? error,
  }) {
    return H1RegisterState(
      status: status ?? this.status,
      records: records ?? this.records,
      message: message,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, records, message, error];
}

sealed class H1RegisterEvent extends Equatable {
  const H1RegisterEvent();

  @override
  List<Object?> get props => [];
}

class H1RegisterLoaded extends H1RegisterEvent {
  const H1RegisterLoaded();
}

class H1RegisterEntrySaved extends H1RegisterEvent {
  const H1RegisterEntrySaved({
    required this.invoiceNo,
    required this.productName,
    required this.prescriberName,
    required this.prescriberAddress,
    required this.patientName,
    required this.patientRegistrationNo,
  });

  final String invoiceNo;
  final String productName;
  final String prescriberName;
  final String prescriberAddress;
  final String patientName;
  final String patientRegistrationNo;

  @override
  List<Object?> get props => [
        invoiceNo,
        productName,
        prescriberName,
        prescriberAddress,
        patientName,
        patientRegistrationNo,
      ];
}

class H1RegisterBloc extends Bloc<H1RegisterEvent, H1RegisterState> {
  H1RegisterBloc({ComplianceRepository? repository})
      : _repository = repository ?? ComplianceRepository(),
        super(const H1RegisterState.initial()) {
    on<H1RegisterLoaded>(_onLoaded);
    on<H1RegisterEntrySaved>(_onSaved);
  }

  final ComplianceRepository _repository;

  Future<void> _onLoaded(H1RegisterLoaded event, Emitter<H1RegisterState> emit) async {
    emit(state.copyWith(status: H1Status.loading, error: null, message: null));
    try {
      final records = await _repository.loadH1Records();
      emit(state.copyWith(status: H1Status.loaded, records: records, error: null, message: null));
    } catch (_) {
      emit(state.copyWith(status: H1Status.error, error: 'Unable to load H1 register entries.', message: null));
    }
  }

  Future<void> _onSaved(H1RegisterEntrySaved event, Emitter<H1RegisterState> emit) async {
    if (event.invoiceNo.trim().isEmpty ||
        event.productName.trim().isEmpty ||
        event.prescriberName.trim().isEmpty ||
        event.patientName.trim().isEmpty ||
        event.patientRegistrationNo.trim().isEmpty) {
      emit(state.copyWith(status: H1Status.error, error: 'All H1 fields are mandatory.', message: null));
      return;
    }

    final hasPrescription = await _repository.hasPrescriptionForInvoice(event.invoiceNo.trim());
    if (!hasPrescription) {
      emit(
        state.copyWith(
          status: H1Status.error,
          error: 'Prescription is required before logging H1 sale for this invoice.',
          message: null,
        ),
      );
      return;
    }

    final record = H1Record(
      invoiceNo: event.invoiceNo.trim(),
      productName: event.productName.trim(),
      prescriberName: event.prescriberName.trim(),
      prescriberAddress: event.prescriberAddress.trim(),
      patientName: event.patientName.trim(),
      patientRegistrationNo: event.patientRegistrationNo.trim(),
      saleDate: DateTime.now(),
      retentionUntil: DateTime.now().add(const Duration(days: 365 * 3)),
    );

    await _repository.saveH1Record(record, actor: 'system');
    add(const H1RegisterLoaded());
    emit(state.copyWith(status: H1Status.success, message: 'H1 entry saved (3-year retention).', error: null));
  }
}
