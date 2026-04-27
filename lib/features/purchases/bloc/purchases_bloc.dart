import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../data/database/app_database.dart';

enum PurchasesStatus { initial, loading, loaded, saved, error }

class PurchaseLine extends Equatable {
  const PurchaseLine({
    required this.productName,
    required this.batchNumber,
    required this.quantity,
    required this.purchasePrice,
    required this.gstRate,
    required this.expiryDate,
  });

  final String productName;
  final String batchNumber;
  final double quantity;
  final double purchasePrice;
  final double gstRate;
  final DateTime expiryDate;

  double get taxable => _round2(quantity * purchasePrice);
  double get tax => _round2(taxable * (gstRate / 100));
  double get total => _round2(taxable + tax);

  static double _round2(double value) => (value * 100).round() / 100;

  @override
  List<Object?> get props => [
    productName,
    batchNumber,
    quantity,
    purchasePrice,
    gstRate,
    expiryDate,
  ];
}

class PurchasesState extends Equatable {
  const PurchasesState({
    required this.status,
    required this.lines,
    required this.savedMessage,
    this.error,
  });

  const PurchasesState.initial()
    : status = PurchasesStatus.initial,
      lines = const [],
      savedMessage = null,
      error = null;

  final PurchasesStatus status;
  final List<PurchaseLine> lines;
  final String? savedMessage;
  final String? error;

  double get taxableTotal =>
      _round2(lines.fold(0, (sum, line) => sum + line.taxable));
  double get gstTotal => _round2(lines.fold(0, (sum, line) => sum + line.tax));
  double get invoiceTotal =>
      _round2(lines.fold(0, (sum, line) => sum + line.total));

  PurchasesState copyWith({
    PurchasesStatus? status,
    List<PurchaseLine>? lines,
    String? savedMessage,
    String? error,
  }) {
    return PurchasesState(
      status: status ?? this.status,
      lines: lines ?? this.lines,
      savedMessage: savedMessage,
      error: error,
    );
  }

  static double _round2(double value) => (value * 100).round() / 100;

  @override
  List<Object?> get props => [status, lines, savedMessage, error];
}

sealed class PurchasesEvent extends Equatable {
  const PurchasesEvent();

  @override
  List<Object?> get props => [];
}

class PurchasesStarted extends PurchasesEvent {
  const PurchasesStarted();
}

class PurchaseLineAdded extends PurchasesEvent {
  const PurchaseLineAdded({
    required this.productName,
    required this.batchNumber,
    required this.quantity,
    required this.purchasePrice,
    required this.gstRate,
    required this.expiryDate,
  });

  final String productName;
  final String batchNumber;
  final double quantity;
  final double purchasePrice;
  final double gstRate;
  final DateTime expiryDate;

  @override
  List<Object?> get props => [
    productName,
    batchNumber,
    quantity,
    purchasePrice,
    gstRate,
    expiryDate,
  ];
}

class PurchaseInvoiceSaved extends PurchasesEvent {
  const PurchaseInvoiceSaved({
    required this.supplierName,
    required this.supplierGstin,
  });

  final String supplierName;
  final String supplierGstin;

  @override
  List<Object?> get props => [supplierName, supplierGstin];
}

class PurchasesBloc extends Bloc<PurchasesEvent, PurchasesState> {
  PurchasesBloc({AppDatabase? database})
    : _database = database ?? getIt<AppDatabase>(),
      super(const PurchasesState.initial()) {
    on<PurchasesStarted>(_onStarted);
    on<PurchaseLineAdded>(_onLineAdded);
    on<PurchaseInvoiceSaved>(_onSaved);
  }

  final AppDatabase _database;

  void _onStarted(PurchasesStarted event, Emitter<PurchasesState> emit) {
    emit(
      state.copyWith(
        status: PurchasesStatus.loaded,
        error: null,
        savedMessage: null,
      ),
    );
  }

  void _onLineAdded(PurchaseLineAdded event, Emitter<PurchasesState> emit) {
    emit(
      state.copyWith(
        status: PurchasesStatus.loading,
        error: null,
        savedMessage: null,
      ),
    );

    if (event.productName.trim().isEmpty || event.batchNumber.trim().isEmpty) {
      emit(
        state.copyWith(
          status: PurchasesStatus.error,
          error: 'Product and batch number are required.',
        ),
      );
      return;
    }

    if (event.quantity <= 0 || event.purchasePrice <= 0) {
      emit(
        state.copyWith(
          status: PurchasesStatus.error,
          error: 'Quantity and purchase price must be positive.',
        ),
      );
      return;
    }

    final line = PurchaseLine(
      productName: event.productName.trim(),
      batchNumber: event.batchNumber.trim(),
      quantity: event.quantity,
      purchasePrice: event.purchasePrice,
      gstRate: event.gstRate,
      expiryDate: event.expiryDate,
    );

    final updated = List<PurchaseLine>.from(state.lines)..add(line);
    emit(
      state.copyWith(
        status: PurchasesStatus.loaded,
        lines: updated,
        error: null,
      ),
    );
  }

  Future<void> _onSaved(
    PurchaseInvoiceSaved event,
    Emitter<PurchasesState> emit,
  ) async {
    emit(
      state.copyWith(
        status: PurchasesStatus.loading,
        error: null,
        savedMessage: null,
      ),
    );

    if (state.lines.isEmpty) {
      emit(
        state.copyWith(
          status: PurchasesStatus.error,
          error: 'Add at least one purchase line before saving.',
        ),
      );
      return;
    }

    if (event.supplierName.trim().isEmpty) {
      emit(
        state.copyWith(
          status: PurchasesStatus.error,
          error: 'Supplier name is required.',
        ),
      );
      return;
    }

    final items = state.lines
        .map(
          (line) => PurchaseItemInput(
            productName: line.productName,
            batchNumber: line.batchNumber,
            quantity: line.quantity,
            purchasePrice: line.purchasePrice,
            gstRate: line.gstRate,
            expDate: line.expiryDate,
          ),
        )
        .toList();

    final invoiceId = await _database.purchaseDao.savePurchaseInvoice(
      supplierName: event.supplierName.trim(),
      supplierGstin: event.supplierGstin.trim(),
      items: items,
      actor: 'system',
    );

    final message =
        'Saved purchase #$invoiceId for ${event.supplierName.trim()} with ${state.lines.length} line(s).';
    emit(
      state.copyWith(
        status: PurchasesStatus.saved,
        savedMessage: message,
        error: null,
      ),
    );
    emit(
      state.copyWith(
        status: PurchasesStatus.loaded,
        savedMessage: message,
        error: null,
      ),
    );
  }
}
