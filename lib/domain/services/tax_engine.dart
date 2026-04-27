class TaxBreakdown {
  const TaxBreakdown({
    required this.taxableValue,
    required this.cgst,
    required this.sgst,
    required this.igst,
    required this.totalTax,
    required this.lineTotal,
  });

  final double taxableValue;
  final double cgst;
  final double sgst;
  final double igst;
  final double totalTax;
  final double lineTotal;
}

class TaxEngine {
  const TaxEngine();

  TaxBreakdown calculate({
    required double unitPrice,
    required double quantity,
    required double gstRate,
    required bool isIntraState,
    double discount = 0,
  }) {
    final gross = _round2(unitPrice * quantity);
    final taxable = _round2((gross - discount).clamp(0, double.infinity));

    if (isIntraState) {
      final halfRate = gstRate / 2;
      final cgst = _round2(taxable * (halfRate / 100));
      final sgst = _round2(taxable * (halfRate / 100));
      final totalTax = _round2(cgst + sgst);

      return TaxBreakdown(
        taxableValue: taxable,
        cgst: cgst,
        sgst: sgst,
        igst: 0,
        totalTax: totalTax,
        lineTotal: _round2(taxable + totalTax),
      );
    }

    final igst = _round2(taxable * (gstRate / 100));
    return TaxBreakdown(
      taxableValue: taxable,
      cgst: 0,
      sgst: 0,
      igst: igst,
      totalTax: igst,
      lineTotal: _round2(taxable + igst),
    );
  }

  double _round2(double value) => (value * 100).round() / 100;
}
