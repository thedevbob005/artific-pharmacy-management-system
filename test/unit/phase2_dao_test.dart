import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:artific_pharmacy_management_system/data/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('purchase save creates invoice items and inventory batches', () async {
    final invoiceId = await database.purchaseDao.savePurchaseInvoice(
      supplierName: 'Om Pharma',
      supplierGstin: '27AAACO1234B1Z5',
      items: [
        PurchaseItemInput(
          productName: 'Paracetamol 500',
          batchNumber: 'P500-B1',
          quantity: 10,
          purchasePrice: 8,
          gstRate: 12,
          expDate: DateTime(2027, 1, 1),
        ),
      ],
      actor: 'admin',
    );

    final invoices = await database.select(database.purchaseInvoices).get();
    final items = await database.select(database.purchaseInvoiceItems).get();
    final batches = await database.select(database.batches).get();

    expect(invoiceId, greaterThan(0));
    expect(invoices, hasLength(1));
    expect(items, hasLength(1));
    expect(batches, hasLength(1));
    expect(invoices.single.totalAmount, 89.6);
  });

  test('return save creates credit note and items', () async {
    final creditId = await database.returnDao.createCreditNote(
      originalInvoiceNo: 'INV-2526-00001',
      originalInvoiceDate: DateTime(2026, 4, 10),
      returnDate: DateTime(2026, 4, 15),
      items: const [
        ReturnItemInput(
          productName: 'Paracetamol 500',
          batchNumber: 'P500-B1',
          quantity: 2,
          unitPrice: 10,
          taxRate: 12,
        ),
      ],
      actor: 'admin',
    );

    final notes = await database.select(database.creditNotes).get();
    final items = await database.select(database.creditNoteItems).get();

    expect(creditId, greaterThan(0));
    expect(notes, hasLength(1));
    expect(items, hasLength(1));
    expect(notes.single.totalAmount, 22.4);
  });
}
