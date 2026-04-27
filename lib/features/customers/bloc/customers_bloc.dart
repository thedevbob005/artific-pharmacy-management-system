import 'package:equatable/equatable.dart';
import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../data/database/app_database.dart';

enum CustomersStatus { initial, loading, loaded, error, saved }

class CustomerRecord extends Equatable {
  const CustomerRecord({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.category,
    required this.totalPurchases,
    required this.lastPurchaseAt,
  });

  final int id;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String category;
  final double totalPurchases;
  final DateTime? lastPurchaseAt;

  factory CustomerRecord.fromRow(Customer row) {
    return CustomerRecord(
      id: row.id,
      name: row.name,
      phone: row.phone,
      email: row.email ?? '',
      address: row.address ?? '',
      category: row.category,
      totalPurchases: row.totalPurchases,
      lastPurchaseAt: row.lastPurchaseAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    phone,
    email,
    address,
    category,
    totalPurchases,
    lastPurchaseAt,
  ];
}

class CustomersState extends Equatable {
  const CustomersState({
    required this.status,
    required this.customers,
    this.selectedCustomer,
    this.error,
  });

  const CustomersState.initial()
    : status = CustomersStatus.initial,
      customers = const [],
      selectedCustomer = null,
      error = null;

  final CustomersStatus status;
  final List<CustomerRecord> customers;
  final CustomerRecord? selectedCustomer;
  final String? error;

  CustomersState copyWith({
    CustomersStatus? status,
    List<CustomerRecord>? customers,
    CustomerRecord? selectedCustomer,
    String? error,
    bool clearSelection = false,
  }) {
    return CustomersState(
      status: status ?? this.status,
      customers: customers ?? this.customers,
      selectedCustomer: clearSelection
          ? null
          : selectedCustomer ?? this.selectedCustomer,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, customers, selectedCustomer, error];
}

sealed class CustomersEvent extends Equatable {
  const CustomersEvent();

  @override
  List<Object?> get props => [];
}

class CustomersStarted extends CustomersEvent {
  const CustomersStarted();
}

class CustomerSaved extends CustomersEvent {
  const CustomerSaved({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.category,
  });

  final String name;
  final String phone;
  final String email;
  final String address;
  final String category;

  @override
  List<Object?> get props => [name, phone, email, address, category];
}

class CustomerSelected extends CustomersEvent {
  const CustomerSelected(this.customerId);

  final int customerId;

  @override
  List<Object?> get props => [customerId];
}

class CustomerDeleted extends CustomersEvent {
  const CustomerDeleted(this.customerId);

  final int customerId;

  @override
  List<Object?> get props => [customerId];
}

class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  CustomersBloc({AppDatabase? database})
    : _database = database ?? getIt<AppDatabase>(),
      super(const CustomersState.initial()) {
    on<CustomersStarted>(_onStarted);
    on<CustomerSaved>(_onSaved);
    on<CustomerSelected>(_onSelected);
    on<CustomerDeleted>(_onDeleted);
  }

  final AppDatabase _database;

  Future<void> _onStarted(
    CustomersStarted event,
    Emitter<CustomersState> emit,
  ) async {
    emit(state.copyWith(status: CustomersStatus.loading, error: null));
    final rows = await _database.customerDao.getAll();
    emit(
      state.copyWith(
        status: CustomersStatus.loaded,
        customers: rows.map(CustomerRecord.fromRow).toList(),
      ),
    );
  }

  Future<void> _onSaved(
    CustomerSaved event,
    Emitter<CustomersState> emit,
  ) async {
    emit(state.copyWith(status: CustomersStatus.loading, error: null));
    final trimmedName = event.name.trim();
    final trimmedPhone = event.phone.trim();

    if (trimmedName.isEmpty || trimmedPhone.isEmpty) {
      emit(
        state.copyWith(
          status: CustomersStatus.error,
          error: 'Name and phone are required.',
        ),
      );
      return;
    }

    try {
      await _database.customerDao.createCustomer(
        CustomersCompanion.insert(
          name: trimmedName,
          phone: trimmedPhone,
          email: Value(event.email.trim().isEmpty ? null : event.email.trim()),
          address: Value(
            event.address.trim().isEmpty ? null : event.address.trim(),
          ),
          category: Value(
            event.category.trim().isEmpty ? 'Regular' : event.category.trim(),
          ),
        ),
        actor: 'system',
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: CustomersStatus.error,
          error: 'Duplicate customer phone number found.',
        ),
      );
      return;
    }

    final rows = await _database.customerDao.getAll();
    final customers = rows.map(CustomerRecord.fromRow).toList();
    emit(
      state.copyWith(
        status: CustomersStatus.saved,
        customers: customers,
        error: null,
      ),
    );
    emit(
      state.copyWith(
        status: CustomersStatus.loaded,
        customers: customers,
        error: null,
      ),
    );
  }

  void _onSelected(CustomerSelected event, Emitter<CustomersState> emit) {
    final selected = state.customers
        .where((customer) => customer.id == event.customerId)
        .firstOrNull;
    emit(
      state.copyWith(
        selectedCustomer: selected,
        status: CustomersStatus.loaded,
        error: null,
      ),
    );
  }

  Future<void> _onDeleted(
    CustomerDeleted event,
    Emitter<CustomersState> emit,
  ) async {
    await _database.customerDao.deleteCustomer(
      event.customerId,
      actor: 'system',
    );
    final rows = await _database.customerDao.getAll();
    final updated = rows.map(CustomerRecord.fromRow).toList();
    emit(
      state.copyWith(
        customers: updated,
        status: CustomersStatus.loaded,
        error: null,
        clearSelection: state.selectedCustomer?.id == event.customerId,
      ),
    );
  }
}
