import 'package:flutter_test/flutter_test.dart';

import 'package:artific_pharmacy_management_system/domain/services/fefo_service.dart';
import 'package:artific_pharmacy_management_system/domain/services/invoice_number.dart';
import 'package:artific_pharmacy_management_system/domain/services/tax_engine.dart';

void main() {
  group('TaxEngine', () {
    test('calculates intra-state GST as CGST + SGST', () {
      const engine = TaxEngine();
      final result = engine.calculate(
        unitPrice: 100,
        quantity: 2,
        gstRate: 12,
        isIntraState: true,
        discount: 10,
      );

      expect(result.taxableValue, 190);
      expect(result.cgst, 11.4);
      expect(result.sgst, 11.4);
      expect(result.igst, 0);
    });
  });

  group('FefoService', () {
    test('allocates from earliest expiry first', () {
      const service = FefoService();
      final result = service.allocate(
        requestedQty: 12,
        now: DateTime(2026, 4, 1),
        batches: const [
          BatchStock(batchId: 1, expDate: DateTime(2026, 7, 1), availableQty: 5),
          BatchStock(batchId: 2, expDate: DateTime(2026, 5, 1), availableQty: 10),
        ],
      );

      expect(result.first.batchId, 2);
      expect(result.first.allocatedQty, 10);
      expect(result.last.batchId, 1);
      expect(result.last.allocatedQty, 2);
    });
  });

  group('InvoiceNumberService', () {
    test('generates FY-bound invoice number', () {
      const service = InvoiceNumberService();
      final invoice = service.generate(date: DateTime(2026, 4, 1), sequence: 1);
      expect(invoice, 'INV-2627-00001');
    });
  });
}
