import 'dart:convert';

import '../../../core/di/service_locator.dart';
import '../../../data/database/app_database.dart';
import '../models/compliance_models.dart';

class ComplianceRepository {
  ComplianceRepository({AppDatabase? database}) : _database = database ?? getIt<AppDatabase>();

  final AppDatabase _database;

  Future<List<H1Record>> loadH1Records() async {
    final payloads = await _database.auditLogDao.getPayloadsByEntity('h1_register');
    return payloads.map(H1Record.fromJson).toList();
  }

  Future<List<NdpsRecord>> loadNdpsRecords() async {
    final payloads = await _database.auditLogDao.getPayloadsByEntity('ndps_register');
    return payloads.map(NdpsRecord.fromJson).toList();
  }

  Future<List<PrescriptionRecord>> loadPrescriptionRecords() async {
    final payloads = await _database.auditLogDao.getPayloadsByEntity('prescription');
    return payloads.map(PrescriptionRecord.fromJson).toList();
  }

  Future<void> saveH1Record(H1Record record, {required String actor}) {
    return _database.auditLogDao.addLog(
      entity: 'h1_register',
      action: 'create',
      actor: actor,
      payload: jsonEncode(record.toJson()),
    );
  }

  Future<void> saveNdpsRecord(NdpsRecord record, {required String actor}) {
    return _database.auditLogDao.addLog(
      entity: 'ndps_register',
      action: 'create',
      actor: actor,
      payload: jsonEncode(record.toJson()),
    );
  }

  Future<void> savePrescriptionRecord(PrescriptionRecord record, {required String actor}) {
    return _database.auditLogDao.addLog(
      entity: 'prescription',
      action: 'create',
      actor: actor,
      payload: jsonEncode(record.toJson()),
    );
  }

  Future<bool> hasPrescriptionForInvoice(String invoiceNo) async {
    final records = await loadPrescriptionRecords();
    return records.any((record) => record.invoiceNo.toLowerCase() == invoiceNo.toLowerCase());
  }
}
