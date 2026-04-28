import 'dart:io';
import 'dart:convert';

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

class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text().unique()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get category => text().withDefault(const Constant('Regular'))();
  RealColumn get totalPurchases => real().withDefault(const Constant(0))();
  DateTimeColumn get lastPurchaseAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Contacts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()();
  TextColumn get name => text()();
  TextColumn get phone => text()();
  TextColumn get email => text().nullable()();
  TextColumn get gstin => text().nullable()();
  TextColumn get bankDetails => text().nullable()();
  TextColumn get doctorRegistrationNumber => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class PurchaseInvoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get supplierName => text()();
  TextColumn get supplierGstin => text().nullable()();
  RealColumn get taxableAmount => real()();
  RealColumn get gstAmount => real()();
  RealColumn get totalAmount => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class PurchaseInvoiceItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get purchaseInvoiceId =>
      integer().references(PurchaseInvoices, #id)();
  IntColumn get productId => integer().nullable().references(Products, #id)();
  TextColumn get productName => text()();
  TextColumn get batchNumber => text()();
  RealColumn get quantity => real()();
  RealColumn get purchasePrice => real()();
  RealColumn get gstRate => real()();
  DateTimeColumn get expDate => dateTime()();
}

class CreditNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get originalInvoiceNo => text()();
  DateTimeColumn get originalInvoiceDate => dateTime()();
  DateTimeColumn get returnDate => dateTime()();
  RealColumn get taxableAmount => real().withDefault(const Constant(0))();
  RealColumn get gstAmount => real().withDefault(const Constant(0))();
  RealColumn get totalAmount => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class CreditNoteItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get creditNoteId => integer().references(CreditNotes, #id)();
  TextColumn get productName => text()();
  TextColumn get batchNumber => text()();
  RealColumn get quantity => real()();
  RealColumn get unitPrice => real()();
  RealColumn get taxRate => real()();
}

@DriftDatabase(
  tables: [
    Users,
    Products,
    Batches,
    InventoryAdjustments,
    AuditLogs,
    Invoices,
    Customers,
    Contacts,
    PurchaseInvoices,
    PurchaseInvoiceItems,
    CreditNotes,
    CreditNoteItems,
  ],
  daos: [
    UserDao,
    ProductDao,
    BatchDao,
    AuditLogDao,
    DashboardDao,
    CustomerDao,
    ContactDao,
    PurchaseDao,
    ReturnDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seedDefaults();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(customers);
        await m.createTable(contacts);
        await m.createTable(purchaseInvoices);
        await m.createTable(purchaseInvoiceItems);
        await m.createTable(creditNotes);
        await m.createTable(creditNoteItems);
      }
      if (from < 3) {
        await m.addColumn(creditNotes, creditNotes.taxableAmount);
        await m.addColumn(creditNotes, creditNotes.gstAmount);
      }
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
    return (select(
      users,
    )..where((u) => u.username.equals(username))).getSingleOrNull();
  }
}

@DriftAccessor(tables: [Products, Batches, InventoryAdjustments])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  Stream<List<Product>> watchProducts() => select(products).watch();

  Future<int> createProduct(
    ProductsCompanion companion, {
    required String actor,
  }) async {
    final id = await into(products).insert(companion);
    await attachedDatabase.auditLogDao.addLog(
      entity: 'product',
      action: 'create',
      actor: actor,
      payload: '{"productId":$id}',
    );
    return id;
  }

  Future<int> createBatch(
    BatchesCompanion companion, {
    required String actor,
  }) async {
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
    return (select(
      batches,
    )..where((b) => b.productId.equals(productId))).watch();
  }

  Future<void> adjustStock({
    required int productId,
    required int batchId,
    required double deltaQty,
    required String reason,
    required String actor,
  }) async {
    await transaction(() async {
      final current = await (select(
        batches,
      )..where((b) => b.id.equals(batchId))).getSingle();
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
          ..where(
            (b) =>
                b.productId.equals(productId) & b.quantity.isBiggerThanValue(0),
          )
          ..orderBy([(b) => OrderingTerm.asc(b.expDate)]))
        .get();
  }
}

@DriftAccessor(tables: [Batches])
class BatchDao extends DatabaseAccessor<AppDatabase> with _$BatchDaoMixin {
  BatchDao(super.db);
}

@DriftAccessor(tables: [AuditLogs])
class AuditLogDao extends DatabaseAccessor<AppDatabase>
    with _$AuditLogDaoMixin {
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

  Future<List<AuditLog>> getLogsByEntity(String entity) {
    return (select(auditLogs)
          ..where((l) => l.entity.equals(entity))
          ..orderBy([(l) => OrderingTerm.desc(l.createdAt)]))
        .get();
  }

  Future<List<Map<String, dynamic>>> getPayloadsByEntity(String entity) async {
    final logs = await getLogsByEntity(entity);
    return logs
        .map((log) => jsonDecode(log.payload) as Map<String, dynamic>)
        .toList();
  }
}

@DriftAccessor(tables: [Customers])
class CustomerDao extends DatabaseAccessor<AppDatabase>
    with _$CustomerDaoMixin {
  CustomerDao(super.db);

  Future<List<Customer>> getAll() {
    return (select(
      customers,
    )..orderBy([(c) => OrderingTerm.asc(c.name)])).get();
  }

  Future<int> createCustomer(
    CustomersCompanion companion, {
    required String actor,
  }) async {
    final id = await into(customers).insert(companion);
    await attachedDatabase.auditLogDao.addLog(
      entity: 'customer',
      action: 'create',
      actor: actor,
      payload: '{"customerId":$id}',
    );
    return id;
  }

  Future<void> deleteCustomer(int customerId, {required String actor}) async {
    await (delete(customers)..where((c) => c.id.equals(customerId))).go();
    await attachedDatabase.auditLogDao.addLog(
      entity: 'customer',
      action: 'delete',
      actor: actor,
      payload: '{"customerId":$customerId}',
    );
  }
}

@DriftAccessor(tables: [Contacts])
class ContactDao extends DatabaseAccessor<AppDatabase> with _$ContactDaoMixin {
  ContactDao(super.db);

  Future<List<Contact>> getAll() {
    return (select(contacts)..orderBy([(c) => OrderingTerm.asc(c.name)])).get();
  }

  Future<int> createContact(
    ContactsCompanion companion, {
    required String actor,
  }) async {
    final id = await into(contacts).insert(companion);
    await attachedDatabase.auditLogDao.addLog(
      entity: 'contact',
      action: 'create',
      actor: actor,
      payload: '{"contactId":$id}',
    );
    return id;
  }

  Future<List<String>> supplierSuggestions(String query) async {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      final rows =
          await (select(contacts)
                ..where((c) => c.type.equals('supplier'))
                ..orderBy([(c) => OrderingTerm.asc(c.name)])
                ..limit(8))
              .get();
      return rows.map((row) => row.name).toList();
    }

    final rows =
        await (select(contacts)
              ..where(
                (c) =>
                    c.type.equals('supplier') &
                    c.name.lower().like('%$normalized%'),
              )
              ..orderBy([(c) => OrderingTerm.asc(c.name)])
              ..limit(8))
            .get();
    return rows.map((row) => row.name).toList();
  }
}

class PurchaseItemInput {
  const PurchaseItemInput({
    required this.productName,
    required this.batchNumber,
    required this.quantity,
    required this.purchasePrice,
    required this.gstRate,
    required this.expDate,
  });

  final String productName;
  final String batchNumber;
  final double quantity;
  final double purchasePrice;
  final double gstRate;
  final DateTime expDate;
}

@DriftAccessor(
  tables: [PurchaseInvoices, PurchaseInvoiceItems, Products, Batches],
)
class PurchaseDao extends DatabaseAccessor<AppDatabase>
    with _$PurchaseDaoMixin {
  PurchaseDao(super.db);

  Future<List<PurchaseInvoice>> getInvoices() {
    return (select(
      purchaseInvoices,
    )..orderBy([(i) => OrderingTerm.desc(i.createdAt)])).get();
  }

  Future<List<PurchaseInvoiceItem>> getInvoiceItems(int invoiceId) {
    return (select(purchaseInvoiceItems)
          ..where((i) => i.purchaseInvoiceId.equals(invoiceId))
          ..orderBy([(i) => OrderingTerm.asc(i.id)]))
        .get();
  }

  Future<int> savePurchaseInvoice({
    required String supplierName,
    required String supplierGstin,
    required List<PurchaseItemInput> items,
    required String actor,
  }) async {
    return transaction(() async {
      final taxable = _round2(
        items.fold<double>(
          0,
          (sum, item) => sum + (item.quantity * item.purchasePrice),
        ),
      );
      final gst = _round2(
        items.fold<double>(
          0,
          (sum, item) =>
              sum +
              ((item.quantity * item.purchasePrice) * (item.gstRate / 100)),
        ),
      );
      final total = _round2(taxable + gst);

      final invoiceId = await into(purchaseInvoices).insert(
        PurchaseInvoicesCompanion.insert(
          supplierName: supplierName,
          supplierGstin: Value(supplierGstin.isEmpty ? null : supplierGstin),
          taxableAmount: taxable,
          gstAmount: gst,
          totalAmount: total,
        ),
      );

      for (final item in items) {
        final product = await (select(
          products,
        )..where((p) => p.name.equals(item.productName))).getSingleOrNull();
        final productId =
            product?.id ??
            await into(products).insert(
              ProductsCompanion.insert(
                name: item.productName,
                hsnCode: '3004',
                gstRate: item.gstRate,
                mrp: _round2(item.purchasePrice * 1.2),
              ),
            );

        await into(batches).insert(
          BatchesCompanion.insert(
            productId: productId,
            batchNumber: item.batchNumber,
            expDate: item.expDate,
            quantity: item.quantity,
            purchasePrice: item.purchasePrice,
          ),
        );

        await into(purchaseInvoiceItems).insert(
          PurchaseInvoiceItemsCompanion.insert(
            purchaseInvoiceId: invoiceId,
            productId: Value(productId),
            productName: item.productName,
            batchNumber: item.batchNumber,
            quantity: item.quantity,
            purchasePrice: item.purchasePrice,
            gstRate: item.gstRate,
            expDate: item.expDate,
          ),
        );
      }

      await attachedDatabase.auditLogDao.addLog(
        entity: 'purchase_invoice',
        action: 'create',
        actor: actor,
        payload: '{"purchaseInvoiceId":$invoiceId,"lineCount":${items.length}}',
      );

      return invoiceId;
    });
  }

  double _round2(double value) => (value * 100).round() / 100;
}

class ReturnItemInput {
  const ReturnItemInput({
    required this.productName,
    required this.batchNumber,
    required this.quantity,
    required this.unitPrice,
    required this.taxRate,
  });

  final String productName;
  final String batchNumber;
  final double quantity;
  final double unitPrice;
  final double taxRate;
}

@DriftAccessor(tables: [CreditNotes, CreditNoteItems, Products, Batches])
class ReturnDao extends DatabaseAccessor<AppDatabase> with _$ReturnDaoMixin {
  ReturnDao(super.db);

  Future<int> createCreditNote({
    required String originalInvoiceNo,
    required DateTime originalInvoiceDate,
    required DateTime returnDate,
    required List<ReturnItemInput> items,
    required String actor,
  }) async {
    return transaction(() async {
      final taxable = _round2(
        items.fold<double>(
          0,
          (sum, item) => sum + (item.quantity * item.unitPrice),
        ),
      );
      final gst = _round2(
        items.fold<double>(
          0,
          (sum, item) =>
              sum + ((item.quantity * item.unitPrice) * (item.taxRate / 100)),
        ),
      );
      final total = _round2(taxable + gst);

      final creditId = await into(creditNotes).insert(
        CreditNotesCompanion.insert(
          originalInvoiceNo: originalInvoiceNo,
          originalInvoiceDate: originalInvoiceDate,
          returnDate: returnDate,
          taxableAmount: Value(taxable),
          gstAmount: Value(gst),
          totalAmount: total,
        ),
      );

      for (final item in items) {
        await into(creditNoteItems).insert(
          CreditNoteItemsCompanion.insert(
            creditNoteId: creditId,
            productName: item.productName,
            batchNumber: item.batchNumber,
            quantity: item.quantity,
            unitPrice: item.unitPrice,
            taxRate: item.taxRate,
          ),
        );

        final matchedProduct = await (select(
          products,
        )..where((p) => p.name.equals(item.productName))).getSingleOrNull();
        if (matchedProduct != null) {
          final matchedBatch =
              await (select(batches)..where(
                    (b) =>
                        b.productId.equals(matchedProduct.id) &
                        b.batchNumber.equals(item.batchNumber),
                  ))
                  .getSingleOrNull();
          if (matchedBatch != null) {
            final nextQty = _round2(matchedBatch.quantity + item.quantity);
            await (update(batches)..where((b) => b.id.equals(matchedBatch.id)))
                .write(BatchesCompanion(quantity: Value(nextQty)));
          } else {
            await into(batches).insert(
              BatchesCompanion.insert(
                productId: matchedProduct.id,
                batchNumber: item.batchNumber,
                expDate: returnDate.add(const Duration(days: 365)),
                quantity: item.quantity,
                purchasePrice: item.unitPrice,
              ),
            );
          }
        }
      }

      await attachedDatabase.auditLogDao.addLog(
        entity: 'credit_note',
        action: 'create',
        actor: actor,
        payload: '{"creditNoteId":$creditId,"lineCount":${items.length}}',
      );

      return creditId;
    });
  }

  double _round2(double value) => (value * 100).round() / 100;
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
class DashboardDao extends DatabaseAccessor<AppDatabase>
    with _$DashboardDaoMixin {
  DashboardDao(super.db);

  Future<DashboardMetrics> getMetrics({DateTime? now}) async {
    final current = now ?? DateTime.now();
    final start = DateTime(current.year, current.month, current.day);
    final end = start.add(const Duration(days: 1));

    final todayInvoices = await (select(
      invoices,
    )..where((i) => i.createdAt.isBetweenValues(start, end))).get();
    final sales = todayInvoices.fold<double>(
      0,
      (sum, i) => sum + i.totalAmount,
    );

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
      final stock =
          await (selectOnly(batches)
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
    final rows =
        await (select(batches)..where(
              (b) =>
                  b.expDate.isSmallerOrEqualValue(threshold) &
                  b.quantity.isBiggerThanValue(0),
            ))
            .get();
    return rows.length;
  }
}
