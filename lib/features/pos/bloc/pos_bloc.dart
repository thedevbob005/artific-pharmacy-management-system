import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../data/database/app_database.dart';
import '../../../domain/services/fefo_service.dart';
import '../../../domain/services/tax_engine.dart';

class PosLineItem extends Equatable {
  const PosLineItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.gstRate,
    required this.discount,
    required this.allocations,
  });

  final int productId;
  final String name;
  final double quantity;
  final double unitPrice;
  final double gstRate;
  final double discount;
  final List<BatchAllocation> allocations;

  TaxBreakdown taxBreakdown({required TaxEngine engine, required bool isIntraState}) {
    return engine.calculate(
      unitPrice: unitPrice,
      quantity: quantity,
      gstRate: gstRate,
      isIntraState: isIntraState,
      discount: discount,
    );
  }

  PosLineItem copyWith({double? quantity, double? discount, List<BatchAllocation>? allocations}) {
    return PosLineItem(
      productId: productId,
      name: name,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice,
      gstRate: gstRate,
      discount: discount ?? this.discount,
      allocations: allocations ?? this.allocations,
    );
  }

  @override
  List<Object?> get props => [productId, quantity, unitPrice, gstRate, discount, allocations];
}

enum PosStatus { initial, loading, ready, error }

class PosState extends Equatable {
  const PosState({
    required this.status,
    required this.items,
    required this.invoiceDiscount,
    required this.isIntraState,
    required this.error,
  });

  const PosState.initial()
      : status = PosStatus.initial,
        items = const [],
        invoiceDiscount = 0,
        isIntraState = true,
        error = null;

  final PosStatus status;
  final List<PosLineItem> items;
  final double invoiceDiscount;
  final bool isIntraState;
  final String? error;

  double taxableTotal(TaxEngine engine) =>
      _round2(items.fold(0, (sum, item) => sum + item.taxBreakdown(engine: engine, isIntraState: isIntraState).taxableValue));

  double taxTotal(TaxEngine engine) =>
      _round2(items.fold(0, (sum, item) => sum + item.taxBreakdown(engine: engine, isIntraState: isIntraState).totalTax));

  double grandTotal(TaxEngine engine) {
    final totalBeforeInvoiceDiscount =
        _round2(items.fold(0, (sum, item) => sum + item.taxBreakdown(engine: engine, isIntraState: isIntraState).lineTotal));
    return _round2((totalBeforeInvoiceDiscount - invoiceDiscount).clamp(0, double.infinity));
  }

  PosState copyWith({
    PosStatus? status,
    List<PosLineItem>? items,
    double? invoiceDiscount,
    bool? isIntraState,
    String? error,
  }) {
    return PosState(
      status: status ?? this.status,
      items: items ?? this.items,
      invoiceDiscount: invoiceDiscount ?? this.invoiceDiscount,
      isIntraState: isIntraState ?? this.isIntraState,
      error: error,
    );
  }

  static double _round2(double value) => (value * 100).round() / 100;

  @override
  List<Object?> get props => [status, items, invoiceDiscount, isIntraState, error];
}

sealed class PosEvent extends Equatable {
  const PosEvent();

  @override
  List<Object?> get props => [];
}

class PosStarted extends PosEvent {
  const PosStarted();
}

class PosItemAdded extends PosEvent {
  const PosItemAdded({required this.productId, required this.quantity, this.discount = 0});

  final int productId;
  final double quantity;
  final double discount;

  @override
  List<Object?> get props => [productId, quantity, discount];
}

class PosInvoiceDiscountUpdated extends PosEvent {
  const PosInvoiceDiscountUpdated(this.discount);

  final double discount;

  @override
  List<Object?> get props => [discount];
}

class PosCustomerStateChanged extends PosEvent {
  const PosCustomerStateChanged({required this.isIntraState});

  final bool isIntraState;

  @override
  List<Object?> get props => [isIntraState];
}

class PosBloc extends Bloc<PosEvent, PosState> {
  PosBloc({
    AppDatabase? database,
    TaxEngine? taxEngine,
    FefoService? fefoService,
  })  : _database = database ?? getIt<AppDatabase>(),
        _taxEngine = taxEngine ?? getIt<TaxEngine>(),
        _fefoService = fefoService ?? getIt<FefoService>(),
        super(const PosState.initial()) {
    on<PosStarted>(_onStarted);
    on<PosItemAdded>(_onItemAdded);
    on<PosInvoiceDiscountUpdated>(_onInvoiceDiscountUpdated);
    on<PosCustomerStateChanged>(_onCustomerStateChanged);
  }

  final AppDatabase _database;
  final TaxEngine _taxEngine;
  final FefoService _fefoService;

  TaxEngine get taxEngine => _taxEngine;

  void _onStarted(PosStarted event, Emitter<PosState> emit) {
    emit(state.copyWith(status: PosStatus.ready, error: null));
  }

  Future<void> _onItemAdded(PosItemAdded event, Emitter<PosState> emit) async {
    emit(state.copyWith(status: PosStatus.loading, error: null));

    try {
      final product = await (_database.select(_database.products)..where((p) => p.id.equals(event.productId))).getSingle();
      final batches = await _database.productDao.activeBatchesForProduct(product.id);
      final allocations = _fefoService.allocate(
        batches: batches
            .map((b) => BatchStock(batchId: b.id, expDate: b.expDate, availableQty: b.quantity))
            .toList(),
        requestedQty: event.quantity,
      );

      final updated = List<PosLineItem>.from(state.items)
        ..add(
          PosLineItem(
            productId: product.id,
            name: product.name,
            quantity: event.quantity,
            unitPrice: product.mrp,
            gstRate: product.gstRate,
            discount: event.discount,
            allocations: allocations,
          ),
        );

      emit(state.copyWith(status: PosStatus.ready, items: updated));
    } on StateError catch (error) {
      emit(state.copyWith(status: PosStatus.error, error: error.message));
    } catch (_) {
      emit(state.copyWith(status: PosStatus.error, error: 'Unable to add item to cart.'));
    }
  }

  void _onInvoiceDiscountUpdated(PosInvoiceDiscountUpdated event, Emitter<PosState> emit) {
    emit(
      state.copyWith(
        invoiceDiscount: (event.discount * 100).round() / 100,
        status: PosStatus.ready,
        error: null,
      ),
    );
  }

  void _onCustomerStateChanged(PosCustomerStateChanged event, Emitter<PosState> emit) {
    emit(state.copyWith(isIntraState: event.isIntraState, status: PosStatus.ready, error: null));
  }
}
