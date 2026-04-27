import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../data/database/app_database.dart';

enum ReturnsStatus { initial, loading, loaded, saved, error }

class ReturnLine extends Equatable {
  const ReturnLine({
    required this.productName,
    required this.batchNumber,
    required this.quantity,
    required this.unitPrice,
    required this.taxRate,
  });

  final String productName;
  final String batchNumber;
  final double quantity;
  final double unitPrice;
  final double taxRate;

  double get taxable => _round2(quantity * unitPrice);
  double get tax => _round2(taxable * (taxRate / 100));
  double get total => _round2(taxable + tax);

  static double _round2(double value) => (value * 100).round() / 100;

  @override
  List<Object?> get props => [
    productName,
    batchNumber,
    quantity,
    unitPrice,
    taxRate,
  ];
}

class ReturnsState extends Equatable {
  const ReturnsState({
    required this.status,
    required this.lines,
    required this.maxReturnDays,
    required this.message,
    this.error,
  });

  const ReturnsState.initial()
    : status = ReturnsStatus.initial,
      lines = const [],
      maxReturnDays = 15,
      message = null,
      error = null;

  final ReturnsStatus status;
  final List<ReturnLine> lines;
  final int maxReturnDays;
  final String? message;
  final String? error;

  double get creditValue =>
      _round2(lines.fold(0, (sum, line) => sum + line.total));

  ReturnsState copyWith({
    ReturnsStatus? status,
    List<ReturnLine>? lines,
    int? maxReturnDays,
    String? message,
    String? error,
  }) {
    return ReturnsState(
      status: status ?? this.status,
      lines: lines ?? this.lines,
      maxReturnDays: maxReturnDays ?? this.maxReturnDays,
      message: message,
      error: error,
    );
  }

  static double _round2(double value) => (value * 100).round() / 100;

  @override
  List<Object?> get props => [status, lines, maxReturnDays, message, error];
}

sealed class ReturnsEvent extends Equatable {
  const ReturnsEvent();

  @override
  List<Object?> get props => [];
}

class ReturnsStarted extends ReturnsEvent {
  const ReturnsStarted();
}

class ReturnLineAdded extends ReturnsEvent {
  const ReturnLineAdded({
    required this.productName,
    required this.batchNumber,
    required this.quantity,
    required this.unitPrice,
    required this.taxRate,
  });

  final String productName;
  final String batchNumber;
  final double quantity;
  final double unitPrice;
  final double taxRate;

  @override
  List<Object?> get props => [
    productName,
    batchNumber,
    quantity,
    unitPrice,
    taxRate,
  ];
}

class CreditNoteGenerated extends ReturnsEvent {
  const CreditNoteGenerated({
    required this.originalInvoiceNo,
    required this.originalInvoiceDate,
    required this.returnDate,
  });

  final String originalInvoiceNo;
  final DateTime originalInvoiceDate;
  final DateTime returnDate;

  @override
  List<Object?> get props => [
    originalInvoiceNo,
    originalInvoiceDate,
    returnDate,
  ];
}

class ReturnsBloc extends Bloc<ReturnsEvent, ReturnsState> {
  ReturnsBloc({AppDatabase? database})
    : _database = database ?? getIt<AppDatabase>(),
      super(const ReturnsState.initial()) {
    on<ReturnsStarted>(_onStarted);
    on<ReturnLineAdded>(_onLineAdded);
    on<CreditNoteGenerated>(_onCreditGenerated);
  }

  final AppDatabase _database;

  void _onStarted(ReturnsStarted event, Emitter<ReturnsState> emit) {
    emit(
      state.copyWith(status: ReturnsStatus.loaded, error: null, message: null),
    );
  }

  void _onLineAdded(ReturnLineAdded event, Emitter<ReturnsState> emit) {
    emit(
      state.copyWith(status: ReturnsStatus.loading, error: null, message: null),
    );
    if (event.productName.trim().isEmpty || event.batchNumber.trim().isEmpty) {
      emit(
        state.copyWith(
          status: ReturnsStatus.error,
          error: 'Product and batch are required.',
        ),
      );
      return;
    }

    if (event.quantity <= 0) {
      emit(
        state.copyWith(
          status: ReturnsStatus.error,
          error: 'Return quantity must be greater than zero.',
        ),
      );
      return;
    }

    final line = ReturnLine(
      productName: event.productName.trim(),
      batchNumber: event.batchNumber.trim(),
      quantity: event.quantity,
      unitPrice: event.unitPrice,
      taxRate: event.taxRate,
    );
    final updated = List<ReturnLine>.from(state.lines)..add(line);
    emit(
      state.copyWith(status: ReturnsStatus.loaded, lines: updated, error: null),
    );
  }

  Future<void> _onCreditGenerated(
    CreditNoteGenerated event,
    Emitter<ReturnsState> emit,
  ) async {
    emit(
      state.copyWith(status: ReturnsStatus.loading, error: null, message: null),
    );

    if (event.originalInvoiceNo.trim().isEmpty) {
      emit(
        state.copyWith(
          status: ReturnsStatus.error,
          error: 'Original invoice number is required.',
        ),
      );
      return;
    }

    if (state.lines.isEmpty) {
      emit(
        state.copyWith(
          status: ReturnsStatus.error,
          error: 'Add at least one return line.',
        ),
      );
      return;
    }

    final daysSinceSale = event.returnDate
        .difference(event.originalInvoiceDate)
        .inDays;
    if (daysSinceSale > state.maxReturnDays) {
      emit(
        state.copyWith(
          status: ReturnsStatus.error,
          error:
              'Return window exceeded. Allowed ${state.maxReturnDays} days, got $daysSinceSale days.',
        ),
      );
      return;
    }

    final items = state.lines
        .map(
          (line) => ReturnItemInput(
            productName: line.productName,
            batchNumber: line.batchNumber,
            quantity: line.quantity,
            unitPrice: line.unitPrice,
            taxRate: line.taxRate,
          ),
        )
        .toList();

    final creditId = await _database.returnDao.createCreditNote(
      originalInvoiceNo: event.originalInvoiceNo,
      originalInvoiceDate: event.originalInvoiceDate,
      returnDate: event.returnDate,
      items: items,
      actor: 'system',
    );

    final msg =
        'Credit note #$creditId generated for ${event.originalInvoiceNo}.';
    emit(
      state.copyWith(status: ReturnsStatus.saved, message: msg, error: null),
    );
    emit(
      state.copyWith(status: ReturnsStatus.loaded, message: msg, error: null),
    );
  }
}
