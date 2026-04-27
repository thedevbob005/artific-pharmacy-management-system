class InvoiceNumberService {
  const InvoiceNumberService();

  String financialYear(DateTime date) {
    final startYear = date.month >= 4 ? date.year : date.year - 1;
    final endYear = (startYear + 1) % 100;
    final startSuffix = startYear % 100;
    return '${startSuffix.toString().padLeft(2, '0')}${endYear.toString().padLeft(2, '0')}';
  }

  String generate({required DateTime date, required int sequence}) {
    final fy = financialYear(date);
    return 'INV-$fy-${sequence.toString().padLeft(5, '0')}';
  }
}
