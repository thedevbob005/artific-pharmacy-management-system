import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../data/database/app_database.dart';

enum InventoryStatus { initial, loading, loaded, error }

class InventoryState extends Equatable {
  const InventoryState({required this.status, required this.products, this.error});

  const InventoryState.initial()
      : status = InventoryStatus.initial,
        products = const [],
        error = null;

  final InventoryStatus status;
  final List<Product> products;
  final String? error;

  InventoryState copyWith({InventoryStatus? status, List<Product>? products, String? error}) {
    return InventoryState(
      status: status ?? this.status,
      products: products ?? this.products,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, products, error];
}

sealed class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object?> get props => [];
}

class InventoryStarted extends InventoryEvent {
  const InventoryStarted();
}

class InventoryProductCreated extends InventoryEvent {
  const InventoryProductCreated({
    required this.name,
    required this.hsnCode,
    required this.gstRate,
    required this.mrp,
    required this.actor,
  });

  final String name;
  final String hsnCode;
  final double gstRate;
  final double mrp;
  final String actor;

  @override
  List<Object?> get props => [name, hsnCode, gstRate, mrp, actor];
}

class InventoryStockAdjusted extends InventoryEvent {
  const InventoryStockAdjusted({
    required this.productId,
    required this.batchId,
    required this.deltaQty,
    required this.reason,
    required this.actor,
  });

  final int productId;
  final int batchId;
  final double deltaQty;
  final String reason;
  final String actor;

  @override
  List<Object?> get props => [productId, batchId, deltaQty, reason, actor];
}

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc({AppDatabase? database})
      : _database = database ?? getIt<AppDatabase>(),
        super(const InventoryState.initial()) {
    on<InventoryStarted>(_onStarted);
    on<InventoryProductCreated>(_onProductCreated);
    on<InventoryStockAdjusted>(_onStockAdjusted);
  }

  final AppDatabase _database;

  Future<void> _onStarted(InventoryStarted event, Emitter<InventoryState> emit) async {
    emit(state.copyWith(status: InventoryStatus.loading, error: null));
    final products = await _database.select(_database.products).get();
    emit(state.copyWith(status: InventoryStatus.loaded, products: products));
  }

  Future<void> _onProductCreated(InventoryProductCreated event, Emitter<InventoryState> emit) async {
    emit(state.copyWith(status: InventoryStatus.loading, error: null));
    try {
      await _database.productDao.createProduct(
        ProductsCompanion.insert(
          name: event.name,
          hsnCode: event.hsnCode,
          gstRate: event.gstRate,
          mrp: event.mrp,
        ),
        actor: event.actor,
      );
      final products = await _database.select(_database.products).get();
      emit(state.copyWith(status: InventoryStatus.loaded, products: products));
    } catch (_) {
      emit(state.copyWith(status: InventoryStatus.error, error: 'Unable to create product.'));
    }
  }

  Future<void> _onStockAdjusted(InventoryStockAdjusted event, Emitter<InventoryState> emit) async {
    emit(state.copyWith(status: InventoryStatus.loading, error: null));
    try {
      await _database.productDao.adjustStock(
        productId: event.productId,
        batchId: event.batchId,
        deltaQty: event.deltaQty,
        reason: event.reason,
        actor: event.actor,
      );
      final products = await _database.select(_database.products).get();
      emit(state.copyWith(status: InventoryStatus.loaded, products: products));
    } catch (_) {
      emit(state.copyWith(status: InventoryStatus.error, error: 'Unable to adjust stock.'));
    }
  }
}
