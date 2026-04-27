import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:artific_pharmacy_management_system/data/database/app_database.dart';
import 'package:artific_pharmacy_management_system/features/contacts/bloc/contacts_bloc.dart';
import 'package:artific_pharmacy_management_system/features/customers/bloc/customers_bloc.dart';
import 'package:artific_pharmacy_management_system/features/purchases/bloc/purchases_bloc.dart';
import 'package:artific_pharmacy_management_system/features/returns/bloc/returns_bloc.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('customers bloc persists customer and blocks duplicate phone', () async {
    final bloc = CustomersBloc(database: database);

    bloc.add(const CustomersStarted());
    await Future<void>.delayed(Duration.zero);

    bloc.add(
      const CustomerSaved(
        name: 'Asha',
        phone: '9999999999',
        email: 'asha@example.com',
        address: 'Indore',
        category: 'Regular',
      ),
    );
    await Future<void>.delayed(Duration.zero);

    bloc.add(
      const CustomerSaved(
        name: 'Asha Duplicate',
        phone: '9999999999',
        email: 'dup@example.com',
        address: 'Indore',
        category: 'Regular',
      ),
    );
    await Future<void>.delayed(Duration.zero);

    expect(bloc.state.status, CustomersStatus.error);
    expect(bloc.state.error, contains('Duplicate'));

    await bloc.close();
  });

  test(
    'contacts bloc enforces supplier GSTIN and saves valid supplier',
    () async {
      final bloc = ContactsBloc(database: database);

      bloc.add(const ContactsStarted());
      await Future<void>.delayed(Duration.zero);

      bloc.add(
        const ContactSaved(
          type: ContactType.supplier,
          name: 'No GSTIN',
          phone: '8888888888',
          email: 'supplier@example.com',
        ),
      );
      await Future<void>.delayed(Duration.zero);

      expect(bloc.state.status, ContactsStatus.error);

      bloc.add(
        const ContactSaved(
          type: ContactType.supplier,
          name: 'Om Pharma',
          phone: '7777777777',
          email: 'supplier@example.com',
          gstin: '27AAACO1234B1Z5',
        ),
      );
      await Future<void>.delayed(Duration.zero);

      expect(
        bloc.state.contacts.where((c) => c.name == 'Om Pharma').isNotEmpty,
        isTrue,
      );

      await bloc.close();
    },
  );

  test('purchases bloc saves invoice and returns saved message', () async {
    final bloc = PurchasesBloc(database: database);

    bloc.add(const PurchasesStarted());
    await Future<void>.delayed(Duration.zero);

    bloc.add(
      PurchaseLineAdded(
        productName: 'Paracetamol',
        batchNumber: 'B1',
        quantity: 5,
        purchasePrice: 10,
        gstRate: 12,
        expiryDate: DateTime(2027, 1, 1),
      ),
    );
    await Future<void>.delayed(Duration.zero);

    bloc.add(
      const PurchaseInvoiceSaved(
        supplierName: 'Om Pharma',
        supplierGstin: '27AAACO1234B1Z5',
      ),
    );
    await Future<void>.delayed(Duration.zero);

    expect(bloc.state.savedMessage, contains('Saved purchase'));

    await bloc.close();
  });

  test(
    'returns bloc validates return window and saves valid credit note',
    () async {
      final bloc = ReturnsBloc(database: database);

      bloc.add(const ReturnsStarted());
      await Future<void>.delayed(Duration.zero);

      bloc.add(
        const ReturnLineAdded(
          productName: 'Paracetamol',
          batchNumber: 'B1',
          quantity: 1,
          unitPrice: 10,
          taxRate: 12,
        ),
      );
      await Future<void>.delayed(Duration.zero);

      bloc.add(
        CreditNoteGenerated(
          originalInvoiceNo: 'INV-2526-00002',
          originalInvoiceDate: DateTime(2026, 3, 1),
          returnDate: DateTime(2026, 4, 30),
        ),
      );
      await Future<void>.delayed(Duration.zero);

      expect(bloc.state.status, ReturnsStatus.error);

      bloc.add(
        CreditNoteGenerated(
          originalInvoiceNo: 'INV-2526-00002',
          originalInvoiceDate: DateTime(2026, 4, 20),
          returnDate: DateTime(2026, 4, 28),
        ),
      );
      await Future<void>.delayed(Duration.zero);

      expect(bloc.state.message, contains('Credit note'));

      await bloc.close();
    },
  );
}
