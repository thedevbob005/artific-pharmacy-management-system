import 'package:equatable/equatable.dart';
import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../data/database/app_database.dart';

enum ContactType { supplier, doctor, other }

enum ContactsStatus { initial, loading, loaded, saved, error }

class ContactRecord extends Equatable {
  const ContactRecord({
    required this.id,
    required this.type,
    required this.name,
    required this.phone,
    required this.email,
    this.gstin,
    this.bankDetails,
    this.doctorRegistrationNumber,
  });

  final int id;
  final ContactType type;
  final String name;
  final String phone;
  final String email;
  final String? gstin;
  final String? bankDetails;
  final String? doctorRegistrationNumber;

  factory ContactRecord.fromRow(Contact row) {
    return ContactRecord(
      id: row.id,
      type: switch (row.type) {
        'supplier' => ContactType.supplier,
        'doctor' => ContactType.doctor,
        _ => ContactType.other,
      },
      name: row.name,
      phone: row.phone,
      email: row.email ?? '',
      gstin: row.gstin,
      bankDetails: row.bankDetails,
      doctorRegistrationNumber: row.doctorRegistrationNumber,
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
    name,
    phone,
    email,
    gstin,
    bankDetails,
    doctorRegistrationNumber,
  ];
}

class ContactsState extends Equatable {
  const ContactsState({
    required this.status,
    required this.contacts,
    required this.activeType,
    this.message,
    this.error,
  });

  const ContactsState.initial()
    : status = ContactsStatus.initial,
      contacts = const [],
      activeType = ContactType.supplier,
      message = null,
      error = null;

  final ContactsStatus status;
  final List<ContactRecord> contacts;
  final ContactType activeType;
  final String? message;
  final String? error;

  List<ContactRecord> get filtered =>
      contacts.where((contact) => contact.type == activeType).toList();

  ContactsState copyWith({
    ContactsStatus? status,
    List<ContactRecord>? contacts,
    ContactType? activeType,
    String? message,
    String? error,
  }) {
    return ContactsState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
      activeType: activeType ?? this.activeType,
      message: message,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, contacts, activeType, message, error];
}

sealed class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object?> get props => [];
}

class ContactsStarted extends ContactsEvent {
  const ContactsStarted();
}

class ContactsTabChanged extends ContactsEvent {
  const ContactsTabChanged(this.type);

  final ContactType type;

  @override
  List<Object?> get props => [type];
}

class ContactSaved extends ContactsEvent {
  const ContactSaved({
    required this.type,
    required this.name,
    required this.phone,
    required this.email,
    this.gstin,
    this.bankDetails,
    this.doctorRegistrationNumber,
  });

  final ContactType type;
  final String name;
  final String phone;
  final String email;
  final String? gstin;
  final String? bankDetails;
  final String? doctorRegistrationNumber;

  @override
  List<Object?> get props => [
    type,
    name,
    phone,
    email,
    gstin,
    bankDetails,
    doctorRegistrationNumber,
  ];
}

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc({AppDatabase? database})
    : _database = database ?? getIt<AppDatabase>(),
      super(const ContactsState.initial()) {
    on<ContactsStarted>(_onStarted);
    on<ContactsTabChanged>(_onTabChanged);
    on<ContactSaved>(_onSaved);
  }

  final AppDatabase _database;

  Future<void> _onStarted(
    ContactsStarted event,
    Emitter<ContactsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ContactsStatus.loading,
        error: null,
        message: null,
      ),
    );
    final rows = await _database.contactDao.getAll();
    emit(
      state.copyWith(
        status: ContactsStatus.loaded,
        contacts: rows.map(ContactRecord.fromRow).toList(),
      ),
    );
  }

  void _onTabChanged(ContactsTabChanged event, Emitter<ContactsState> emit) {
    emit(
      state.copyWith(
        activeType: event.type,
        status: ContactsStatus.loaded,
        error: null,
        message: null,
      ),
    );
  }

  Future<void> _onSaved(ContactSaved event, Emitter<ContactsState> emit) async {
    emit(
      state.copyWith(
        status: ContactsStatus.loading,
        error: null,
        message: null,
      ),
    );
    if (event.name.trim().isEmpty || event.phone.trim().isEmpty) {
      emit(
        state.copyWith(
          status: ContactsStatus.error,
          error: 'Name and phone are required.',
        ),
      );
      return;
    }

    if (event.type == ContactType.supplier &&
        (event.gstin ?? '').trim().isEmpty) {
      emit(
        state.copyWith(
          status: ContactsStatus.error,
          error: 'Supplier GSTIN is required.',
        ),
      );
      return;
    }

    if (event.type == ContactType.doctor &&
        (event.doctorRegistrationNumber ?? '').trim().isEmpty) {
      emit(
        state.copyWith(
          status: ContactsStatus.error,
          error: 'Doctor registration number is required.',
        ),
      );
      return;
    }

    await _database.contactDao.createContact(
      ContactsCompanion.insert(
        type: event.type.name,
        name: event.name.trim(),
        phone: event.phone.trim(),
        email: Value(event.email.trim().isEmpty ? null : event.email.trim()),
        gstin: Value(
          event.gstin?.trim().isEmpty ?? true ? null : event.gstin?.trim(),
        ),
        bankDetails: Value(
          event.bankDetails?.trim().isEmpty ?? true
              ? null
              : event.bankDetails?.trim(),
        ),
        doctorRegistrationNumber: Value(
          event.doctorRegistrationNumber?.trim().isEmpty ?? true
              ? null
              : event.doctorRegistrationNumber?.trim(),
        ),
      ),
      actor: 'system',
    );

    final rows = await _database.contactDao.getAll();
    final updated = rows.map(ContactRecord.fromRow).toList();
    emit(
      state.copyWith(
        status: ContactsStatus.saved,
        contacts: updated,
        message: 'Contact saved.',
      ),
    );
    emit(
      state.copyWith(
        status: ContactsStatus.loaded,
        contacts: updated,
        message: 'Contact saved.',
      ),
    );
  }
}
