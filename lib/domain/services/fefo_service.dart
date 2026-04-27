class BatchStock {
  const BatchStock({
    required this.batchId,
    required this.expDate,
    required this.availableQty,
  });

  final int batchId;
  final DateTime expDate;
  final double availableQty;
}

class BatchAllocation {
  const BatchAllocation({required this.batchId, required this.allocatedQty});

  final int batchId;
  final double allocatedQty;
}

class FefoService {
  const FefoService();

  List<BatchAllocation> allocate({
    required List<BatchStock> batches,
    required double requestedQty,
    DateTime? now,
  }) {
    final current = now ?? DateTime.now();
    final sorted = batches
        .where((batch) => batch.expDate.isAfter(current) && batch.availableQty > 0)
        .toList()
      ..sort((a, b) => a.expDate.compareTo(b.expDate));

    var remaining = requestedQty;
    final allocations = <BatchAllocation>[];

    for (final batch in sorted) {
      if (remaining <= 0) break;
      final qty = remaining >= batch.availableQty ? batch.availableQty : remaining;
      allocations.add(BatchAllocation(batchId: batch.batchId, allocatedQty: qty));
      remaining = _round2(remaining - qty);
    }

    if (remaining > 0) {
      throw StateError('Insufficient non-expired stock for FEFO allocation.');
    }

    return allocations;
  }

  double _round2(double value) => (value * 100).round() / 100;
}
