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

  test('stock adjustment writes inventory and audit logs', () async {
    final productId = await database.productDao.createProduct(
      ProductsCompanion.insert(name: 'Paracetamol', hsnCode: '3004', gstRate: 12, mrp: 25),
      actor: 'admin',
    );

    final batchId = await database.productDao.createBatch(
      BatchesCompanion.insert(
        productId: productId,
        batchNumber: 'B1',
        expDate: DateTime(2027, 1, 1),
        quantity: 10,
        purchasePrice: 18,
      ),
      actor: 'admin',
    );

    await database.productDao.adjustStock(
      productId: productId,
      batchId: batchId,
      deltaQty: -2,
      reason: 'damaged strip',
      actor: 'admin',
    );

    final batch = await (database.select(database.batches)..where((b) => b.id.equals(batchId))).getSingle();
    final adjustments = await database.select(database.inventoryAdjustments).get();
    final auditLogs = await database.select(database.auditLogs).get();

    expect(batch.quantity, 8);
    expect(adjustments, hasLength(1));
    expect(adjustments.single.reason, 'damaged strip');
    expect(auditLogs.where((log) => log.entity == 'inventory_adjustment').length, 1);
  });
}
