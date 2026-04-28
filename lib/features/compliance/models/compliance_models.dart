class H1Record {
  const H1Record({
    required this.invoiceNo,
    required this.productName,
    required this.prescriberName,
    required this.prescriberAddress,
    required this.patientName,
    required this.patientRegistrationNo,
    required this.saleDate,
    required this.retentionUntil,
  });

  final String invoiceNo;
  final String productName;
  final String prescriberName;
  final String prescriberAddress;
  final String patientName;
  final String patientRegistrationNo;
  final DateTime saleDate;
  final DateTime retentionUntil;

  factory H1Record.fromJson(Map<String, dynamic> json) {
    return H1Record(
      invoiceNo: json['invoiceNo'] as String? ?? '',
      productName: json['productName'] as String? ?? '',
      prescriberName: json['prescriberName'] as String? ?? '',
      prescriberAddress: json['prescriberAddress'] as String? ?? '',
      patientName: json['patientName'] as String? ?? '',
      patientRegistrationNo: json['patientRegistrationNo'] as String? ?? '',
      saleDate: DateTime.tryParse(json['saleDate'] as String? ?? '') ?? DateTime.now(),
      retentionUntil:
          DateTime.tryParse(json['retentionUntil'] as String? ?? '') ?? DateTime.now().add(const Duration(days: 365 * 3)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invoiceNo': invoiceNo,
      'productName': productName,
      'prescriberName': prescriberName,
      'prescriberAddress': prescriberAddress,
      'patientName': patientName,
      'patientRegistrationNo': patientRegistrationNo,
      'saleDate': saleDate.toIso8601String(),
      'retentionUntil': retentionUntil.toIso8601String(),
    };
  }
}

class NdpsRecord {
  const NdpsRecord({
    required this.formType,
    required this.drugName,
    required this.invoiceNo,
    required this.openingQty,
    required this.receivedQty,
    required this.dispensedQty,
    required this.closingQty,
    this.patientName,
    this.notes,
    required this.recordDate,
    required this.retentionUntil,
  });

  final String formType;
  final String drugName;
  final String invoiceNo;
  final double openingQty;
  final double receivedQty;
  final double dispensedQty;
  final double closingQty;
  final String? patientName;
  final String? notes;
  final DateTime recordDate;
  final DateTime retentionUntil;

  factory NdpsRecord.fromJson(Map<String, dynamic> json) {
    return NdpsRecord(
      formType: json['formType'] as String? ?? '',
      drugName: json['drugName'] as String? ?? '',
      invoiceNo: json['invoiceNo'] as String? ?? '',
      openingQty: (json['openingQty'] as num?)?.toDouble() ?? 0,
      receivedQty: (json['receivedQty'] as num?)?.toDouble() ?? 0,
      dispensedQty: (json['dispensedQty'] as num?)?.toDouble() ?? 0,
      closingQty: (json['closingQty'] as num?)?.toDouble() ?? 0,
      patientName: json['patientName'] as String?,
      notes: json['notes'] as String?,
      recordDate: DateTime.tryParse(json['recordDate'] as String? ?? '') ?? DateTime.now(),
      retentionUntil:
          DateTime.tryParse(json['retentionUntil'] as String? ?? '') ?? DateTime.now().add(const Duration(days: 365 * 2)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'formType': formType,
      'drugName': drugName,
      'invoiceNo': invoiceNo,
      'openingQty': openingQty,
      'receivedQty': receivedQty,
      'dispensedQty': dispensedQty,
      'closingQty': closingQty,
      'patientName': patientName,
      'notes': notes,
      'recordDate': recordDate.toIso8601String(),
      'retentionUntil': retentionUntil.toIso8601String(),
    };
  }
}

class PrescriptionRecord {
  const PrescriptionRecord({
    required this.invoiceNo,
    required this.patientName,
    required this.doctorName,
    required this.filePath,
    required this.uploadedAt,
  });

  final String invoiceNo;
  final String patientName;
  final String doctorName;
  final String filePath;
  final DateTime uploadedAt;

  factory PrescriptionRecord.fromJson(Map<String, dynamic> json) {
    return PrescriptionRecord(
      invoiceNo: json['invoiceNo'] as String? ?? '',
      patientName: json['patientName'] as String? ?? '',
      doctorName: json['doctorName'] as String? ?? '',
      filePath: json['filePath'] as String? ?? '',
      uploadedAt: DateTime.tryParse(json['uploadedAt'] as String? ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invoiceNo': invoiceNo,
      'patientName': patientName,
      'doctorName': doctorName,
      'filePath': filePath,
      'uploadedAt': uploadedAt.toIso8601String(),
    };
  }
}
