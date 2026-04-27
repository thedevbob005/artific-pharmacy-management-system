import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:artific_pharmacy_management_system/data/database/app_database.dart';
import 'package:artific_pharmacy_management_system/domain/services/fefo_service.dart';
import 'package:artific_pharmacy_management_system/domain/services/tax_engine.dart';
import 'package:artific_pharmacy_management_system/features/pos/bloc/pos_bloc.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('adds item and calculates GST totals with FEFO allocations', () async {
    final bloc = PosBloc(database: database, taxEngine: const TaxEngine(), fefoService: const FefoService());

    final productId = await database.into(database.products).insert(
          ProductsCompanion.insert(name: 'Amoxicillin', hsnCode: '3004', gstRate: 12, mrp: 100),
        );

    await database.into(database.batches).insert(
          BatchesCompanion.insert(
            productId: productId,
            batchNumber: 'EARLY',
            expDate: DateTime(2026, 7, 1),
            quantity: 5,
            purchasePrice: 80,
          ),
        );
    await database.into(database.batches).insert(
          BatchesCompanion.insert(
            productId: productId,
            batchNumber: 'LATE',
            expDate: DateTime(2026, 10, 1),
            quantity: 10,
            purchasePrice: 80,
          ),
        );

    bloc.add(const PosStarted());
    await Future<void>.delayed(Duration.zero);
    bloc.add(const PosItemAdded(productId: 1, quantity: 7, discount: 20));
    await Future<void>.delayed(Duration.zero);

    expect(bloc.state.status, PosStatus.ready);
    expect(bloc.state.items.single.allocations.first.allocatedQty, 5);
    expect(bloc.state.items.single.allocations.last.allocatedQty, 2);
    expect(bloc.state.grandTotal(bloc.taxEngine), 761.6);

    await bloc.close();
  });
}
