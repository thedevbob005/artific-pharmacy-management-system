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

class ReturnInvoiceLookup extends Equatable {
  const ReturnInvoiceLookup({
    required this.id,
    required this.supplierName,
    required this.createdAt,
  });

  final int id;
  final String supplierName;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, supplierName, createdAt];
}

class ReturnInvoiceItemLookup extends Equatable {
  const ReturnInvoiceItemLookup({
    required this.productName,
    required this.batchNumber,
    required this.quantity,
    required this.purchasePrice,
    required this.gstRate,
  });

  final String productName;
  final String batchNumber;
  final double quantity;
  final double purchasePrice;
  final double gstRate;

  @override
  List<Object?> get props => [
    productName,
    batchNumber,
    quantity,
    purchasePrice,
    gstRate,
  ];
}

class ReturnsState extends Equatable {
  const ReturnsState({
    required this.status,
    required this.lines,
    required this.availableInvoices,
    required this.availableInvoiceItems,
    required this.selectedInvoiceId,
    required this.maxReturnDays,
    required this.message,
    this.error,
  });

  const ReturnsState.initial()
    : status = ReturnsStatus.initial,
      lines = const [],
      availableInvoices = const [],
      availableInvoiceItems = const [],
      selectedInvoiceId = null,
      maxReturnDays = 15,
      message = null,
      error = null;

  final ReturnsStatus status;
  final List<ReturnLine> lines;
  final List<ReturnInvoiceLookup> availableInvoices;
  final List<ReturnInvoiceItemLookup> availableInvoiceItems;
  final int? selectedInvoiceId;
  final int maxReturnDays;
  final String? message;
  final String? error;

  double get creditValue =>
      _round2(lines.fold(0, (sum, line) => sum + line.total));

  ReturnsState copyWith({
    ReturnsStatus? status,
    List<ReturnLine>? lines,
    List<ReturnInvoiceLookup>? availableInvoices,
    List<ReturnInvoiceItemLookup>? availableInvoiceItems,
    int? selectedInvoiceId,
    int? maxReturnDays,
    String? message,
    String? error,
  }) {
    return ReturnsState(
      status: status ?? this.status,
      lines: lines ?? this.lines,
      availableInvoices: availableInvoices ?? this.availableInvoices,
      availableInvoiceItems:
          availableInvoiceItems ?? this.availableInvoiceItems,
      selectedInvoiceId: selectedInvoiceId ?? this.selectedInvoiceId,
      maxReturnDays: maxReturnDays ?? this.maxReturnDays,
      message: message,
      error: error,
    );
  }

  static double _round2(double value) => (value * 100).round() / 100;

  @override
  List<Object?> get props => [
    status,
    lines,
    availableInvoices,
    availableInvoiceItems,
    selectedInvoiceId,
    maxReturnDays,
    message,
    error,
  ];
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

class ReturnOriginalInvoiceSelected extends ReturnsEvent {
  const ReturnOriginalInvoiceSelected(this.invoiceId);

  final int invoiceId;

  @override
  List<Object?> get props => [invoiceId];
}

class ReturnInvoiceItemPicked extends ReturnsEvent {
  const ReturnInvoiceItemPicked({
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

class ReturnsBloc extends Bloc<ReturnsEvent, ReturnsState> {
  ReturnsBloc({AppDatabase? database})
    : _database = database ?? getIt<AppDatabase>(),
      super(const ReturnsState.initial()) {
    on<ReturnsStarted>(_onStarted);
    on<ReturnLineAdded>(_onLineAdded);
    on<CreditNoteGenerated>(_onCreditGenerated);
    on<ReturnOriginalInvoiceSelected>(_onInvoiceSelected);
    on<ReturnInvoiceItemPicked>(_onInvoiceItemPicked);
  }

  final AppDatabase _database;

  Future<void> _onStarted(
    ReturnsStarted event,
    Emitter<ReturnsState> emit,
  ) async {
    final invoices = await _database.purchaseDao.getInvoices();
    emit(
      state.copyWith(
        status: ReturnsStatus.loaded,
        error: null,
        message: null,
        availableInvoices: invoices
            .map(
              (row) => ReturnInvoiceLookup(
                id: row.id,
                supplierName: row.supplierName,
                createdAt: row.createdAt,
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _onInvoiceSelected(
    ReturnOriginalInvoiceSelected event,
    Emitter<ReturnsState> emit,
  ) async {
    final rows = await _database.purchaseDao.getInvoiceItems(event.invoiceId);
    emit(
      state.copyWith(
        selectedInvoiceId: event.invoiceId,
        availableInvoiceItems: rows
            .map(
              (item) => ReturnInvoiceItemLookup(
                productName: item.productName,
                batchNumber: item.batchNumber,
                quantity: item.quantity,
                purchasePrice: item.purchasePrice,
                gstRate: item.gstRate,
              ),
            )
            .toList(),
        status: ReturnsStatus.loaded,
      ),
    );
  }

  void _onInvoiceItemPicked(
    ReturnInvoiceItemPicked event,
    Emitter<ReturnsState> emit,
  ) {
    add(
      ReturnLineAdded(
        productName: event.productName,
        batchNumber: event.batchNumber,
        quantity: event.quantity,
        unitPrice: event.unitPrice,
        taxRate: event.taxRate,
      ),
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
