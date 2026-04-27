import 'dart:io';

import 'package:bcrypt/bcrypt.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().unique()();
  TextColumn get passwordHash => text()();
  TextColumn get role => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get barcode => text().nullable()();
  TextColumn get hsnCode => text()();
  RealColumn get gstRate => real()();
  RealColumn get mrp => real()();
  RealColumn get lowStockThreshold => real().withDefault(const Constant(10))();
  BoolColumn get isH1 => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Batches extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  TextColumn get batchNumber => text()();
  DateTimeColumn get expDate => dateTime()();
  RealColumn get quantity => real()();
  RealColumn get purchasePrice => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class InventoryAdjustments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get batchId => integer().references(Batches, #id)();
  RealColumn get deltaQty => real()();
  TextColumn get reason => text()();
  TextColumn get performedBy => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class AuditLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entity => text()();
  TextColumn get action => text()();
  TextColumn get actor => text()();
  TextColumn get payload => text().withDefault(const Constant('{}'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Invoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get invoiceNo => text().unique()();
  RealColumn get totalAmount => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(
  tables: [Users, Products, Batches, InventoryAdjustments, AuditLogs, Invoices],
  daos: [UserDao, ProductDao, BatchDao, AuditLogDao, DashboardDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedDefaults();
        },
      );

  Future<void> _seedDefaults() async {
    await into(users).insert(
      UsersCompanion.insert(
        username: 'admin',
        passwordHash: BCrypt.hashpw('admin123', BCrypt.gensalt()),
        role: 'admin',
      ),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'apms.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  Future<User?> findByUsername(String username) {
    return (select(users)..where((u) => u.username.equals(username))).getSingleOrNull();
  }
}

@DriftAccessor(tables: [Products, Batches, InventoryAdjustments])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  Stream<List<Product>> watchProducts() => select(products).watch();

  Future<int> createProduct(ProductsCompanion companion, {required String actor}) async {
    final id = await into(products).insert(companion);
    await attachedDatabase.auditLogDao.addLog(
      entity: 'product',
      action: 'create',
      actor: actor,
      payload: '{"productId":$id}',
    );
    return id;
  }

  Future<int> createBatch(BatchesCompanion companion, {required String actor}) async {
    final id = await into(batches).insert(companion);
    await attachedDatabase.auditLogDao.addLog(
      entity: 'batch',
      action: 'create',
      actor: actor,
      payload: '{"batchId":$id}',
    );
    return id;
  }

  Stream<List<Batche>> watchBatchesForProduct(int productId) {
    return (select(batches)..where((b) => b.productId.equals(productId))).watch();
  }

  Future<void> adjustStock({
    required int productId,
    required int batchId,
    required double deltaQty,
    required String reason,
    required String actor,
  }) async {
    await transaction(() async {
      final current = await (select(batches)..where((b) => b.id.equals(batchId))).getSingle();
      final nextQty = ((current.quantity + deltaQty) * 100).round() / 100;
      await (update(batches)..where((b) => b.id.equals(batchId))).write(
        BatchesCompanion(quantity: Value(nextQty)),
      );

      await into(inventoryAdjustments).insert(
        InventoryAdjustmentsCompanion.insert(
          productId: productId,
          batchId: batchId,
          deltaQty: deltaQty,
          reason: reason,
          performedBy: actor,
        ),
      );

      await attachedDatabase.auditLogDao.addLog(
        entity: 'inventory_adjustment',
        action: 'update',
        actor: actor,
        payload:
            '{"productId":$productId,"batchId":$batchId,"deltaQty":$deltaQty,"reason":"$reason"}',
      );
    });
  }

  Future<List<Batche>> activeBatchesForProduct(int productId) {
    return (select(batches)
          ..where((b) => b.productId.equals(productId) & b.quantity.isBiggerThanValue(0))
          ..orderBy([(b) => OrderingTerm.asc(b.expDate)]))
        .get();
  }
}

@DriftAccessor(tables: [Batches])
class BatchDao extends DatabaseAccessor<AppDatabase> with _$BatchDaoMixin {
  BatchDao(super.db);
}

@DriftAccessor(tables: [AuditLogs])
class AuditLogDao extends DatabaseAccessor<AppDatabase> with _$AuditLogDaoMixin {
  AuditLogDao(super.db);

  Future<void> addLog({
    required String entity,
    required String action,
    required String actor,
    required String payload,
  }) {
    return into(auditLogs).insert(
      AuditLogsCompanion.insert(
        entity: entity,
        action: action,
        actor: actor,
        payload: Value(payload),
      ),
    );
  }
}

class DashboardMetrics {
  const DashboardMetrics({
    required this.todaysSales,
    required this.lowStockProducts,
    required this.expiringSoonBatches,
  });

  final double todaysSales;
  final int lowStockProducts;
  final int expiringSoonBatches;
}

@DriftAccessor(tables: [Invoices, Products, Batches])
class DashboardDao extends DatabaseAccessor<AppDatabase> with _$DashboardDaoMixin {
  DashboardDao(super.db);

  Future<DashboardMetrics> getMetrics({DateTime? now}) async {
    final current = now ?? DateTime.now();
    final start = DateTime(current.year, current.month, current.day);
    final end = start.add(const Duration(days: 1));

    final todayInvoices = await (select(invoices)
          ..where((i) => i.createdAt.isBetweenValues(start, end)))
        .get();
    final sales = todayInvoices.fold<double>(0, (sum, i) => sum + i.totalAmount);

    final productRows = await select(products).get();
    final lowCount = await _countLowStock(productRows);
    final expiringSoon = await _countExpiringSoon(current);

    return DashboardMetrics(
      todaysSales: ((sales * 100).round() / 100),
      lowStockProducts: lowCount,
      expiringSoonBatches: expiringSoon,
    );
  }

  Future<int> _countLowStock(List<Product> productRows) async {
    var low = 0;
    for (final product in productRows) {
      final stock = await (selectOnly(batches)
            ..addColumns([batches.quantity.sum()])
            ..where(batches.productId.equals(product.id)))
          .getSingle();
      final qty = stock.read(batches.quantity.sum()) ?? 0;
      if (qty <= product.lowStockThreshold) {
        low += 1;
      }
    }
    return low;
  }

  Future<int> _countExpiringSoon(DateTime now) async {
    final threshold = now.add(const Duration(days: 30));
    final rows = await (select(batches)
          ..where((b) => b.expDate.isSmallerOrEqualValue(threshold) & b.quantity.isBiggerThanValue(0)))
        .get();
    return rows.length;
  }
}
