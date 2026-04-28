import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../data/database/app_database.dart';
import '../../compliance/models/compliance_models.dart';
import '../../compliance/repository/compliance_repository.dart';
import '../../../domain/services/fefo_service.dart';
import '../../../domain/services/tax_engine.dart';

class PosLineItem extends Equatable {
  const PosLineItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.gstRate,
    required this.discount,
    required this.allocations,
    this.isH1 = false,
    this.hsnCode = '',
  });

  final int productId;
  final String name;
  final double quantity;
  final double unitPrice;
  final double gstRate;
  final double discount;
  final List<BatchAllocation> allocations;
  final bool isH1;
  final String hsnCode;

  TaxBreakdown taxBreakdown({
    required TaxEngine engine,
    required bool isIntraState,
  }) {
    return engine.calculate(
      unitPrice: unitPrice,
      quantity: quantity,
      gstRate: gstRate,
      isIntraState: isIntraState,
      discount: discount,
    );
  }

  PosLineItem copyWith({
    double? quantity,
    double? discount,
    List<BatchAllocation>? allocations,
  }) {
    return PosLineItem(
      productId: productId,
      name: name,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice,
      gstRate: gstRate,
      discount: discount ?? this.discount,
      allocations: allocations ?? this.allocations,
      isH1: isH1,
      hsnCode: hsnCode,
    );
  }

  @override
  List<Object?> get props => [
    productId,
    quantity,
    unitPrice,
    gstRate,
    discount,
    allocations,
    isH1,
    hsnCode,
  ];
}

enum PosStatus { initial, loading, ready, error }

class PosState extends Equatable {
  const PosState({
    required this.status,
    required this.items,
    required this.invoiceDiscount,
    required this.isIntraState,
    required this.error,
    required this.requiresPrescription,
  });

  const PosState.initial()
    : status = PosStatus.initial,
      items = const [],
      invoiceDiscount = 0,
      isIntraState = true,
      error = null,
      requiresPrescription = false;

  final PosStatus status;
  final List<PosLineItem> items;
  final double invoiceDiscount;
  final bool isIntraState;
  final String? error;
  final bool requiresPrescription;

  double taxableTotal(TaxEngine engine) => _round2(
    items.fold(
      0,
      (sum, item) =>
          sum +
          item
              .taxBreakdown(engine: engine, isIntraState: isIntraState)
              .taxableValue,
    ),
  );

  double taxTotal(TaxEngine engine) => _round2(
    items.fold(
      0,
      (sum, item) =>
          sum +
          item
              .taxBreakdown(engine: engine, isIntraState: isIntraState)
              .totalTax,
    ),
  );

  double grandTotal(TaxEngine engine) {
    final totalBeforeInvoiceDiscount = _round2(
      items.fold(
        0,
        (sum, item) =>
            sum +
            item
                .taxBreakdown(engine: engine, isIntraState: isIntraState)
                .lineTotal,
      ),
    );
    return _round2(
      (totalBeforeInvoiceDiscount - invoiceDiscount).clamp(0, double.infinity),
    );
  }

  PosState copyWith({
    PosStatus? status,
    List<PosLineItem>? items,
    double? invoiceDiscount,
    bool? isIntraState,
    String? error,
    bool? requiresPrescription,
  }) {
    return PosState(
      status: status ?? this.status,
      items: items ?? this.items,
      invoiceDiscount: invoiceDiscount ?? this.invoiceDiscount,
      isIntraState: isIntraState ?? this.isIntraState,
      error: error,
      requiresPrescription: requiresPrescription ?? this.requiresPrescription,
    );
  }

  static double _round2(double value) => (value * 100).round() / 100;

  @override
  List<Object?> get props => [
    status,
    items,
    invoiceDiscount,
    isIntraState,
    error,
    requiresPrescription,
  ];
}

sealed class PosEvent extends Equatable {
  const PosEvent();

  @override
  List<Object?> get props => [];
}

class PosStarted extends PosEvent {
  const PosStarted();
}

class PosItemAdded extends PosEvent {
  const PosItemAdded({
    required this.productId,
    required this.quantity,
    this.discount = 0,
  });

  final int productId;
  final double quantity;
  final double discount;

  @override
  List<Object?> get props => [productId, quantity, discount];
}

class PosInvoiceDiscountUpdated extends PosEvent {
  const PosInvoiceDiscountUpdated(this.discount);

  final double discount;

  @override
  List<Object?> get props => [discount];
}

class PosCustomerStateChanged extends PosEvent {
  const PosCustomerStateChanged({required this.isIntraState});

  final bool isIntraState;

  @override
  List<Object?> get props => [isIntraState];
}

class PosCheckoutSubmitted extends PosEvent {
  const PosCheckoutSubmitted({
    required this.patientName,
    required this.prescriberName,
    required this.prescriberAddress,
    required this.patientRegistrationNo,
    required this.prescriptionFilePath,
  });

  final String patientName;
  final String prescriberName;
  final String prescriberAddress;
  final String patientRegistrationNo;
  final String prescriptionFilePath;

  @override
  List<Object?> get props => [
    patientName,
    prescriberName,
    prescriberAddress,
    patientRegistrationNo,
    prescriptionFilePath,
  ];
}

class PosBloc extends Bloc<PosEvent, PosState> {
  PosBloc({
    AppDatabase? database,
    TaxEngine? taxEngine,
    FefoService? fefoService,
    ComplianceRepository? complianceRepository,
  }) : _database = database ?? getIt<AppDatabase>(),
       _taxEngine = taxEngine ?? getIt<TaxEngine>(),
       _fefoService = fefoService ?? getIt<FefoService>(),
       _complianceRepository = complianceRepository,
       super(const PosState.initial()) {
    on<PosStarted>(_onStarted);
    on<PosItemAdded>(_onItemAdded);
    on<PosInvoiceDiscountUpdated>(_onInvoiceDiscountUpdated);
    on<PosCustomerStateChanged>(_onCustomerStateChanged);
    on<PosCheckoutSubmitted>(_onCheckoutSubmitted);
  }

  final AppDatabase _database;
  final TaxEngine _taxEngine;
  final FefoService _fefoService;
  final ComplianceRepository? _complianceRepository;

  TaxEngine get taxEngine => _taxEngine;

  void _onStarted(PosStarted event, Emitter<PosState> emit) {
    emit(state.copyWith(status: PosStatus.ready, error: null));
  }

  Future<void> _onItemAdded(PosItemAdded event, Emitter<PosState> emit) async {
    emit(state.copyWith(status: PosStatus.loading, error: null));

    try {
      final product = await (_database.select(
        _database.products,
      )..where((p) => p.id.equals(event.productId))).getSingle();
      final batches = await _database.productDao.activeBatchesForProduct(
        product.id,
      );
      final allocations = _fefoService.allocate(
        batches: batches
            .map(
              (b) => BatchStock(
                batchId: b.id,
                expDate: b.expDate,
                availableQty: b.quantity,
              ),
            )
            .toList(),
        requestedQty: event.quantity,
      );

      final updated = List<PosLineItem>.from(state.items)
        ..add(
          PosLineItem(
            productId: product.id,
            name: product.name,
            quantity: event.quantity,
            unitPrice: product.mrp,
            gstRate: product.gstRate,
            discount: event.discount,
            allocations: allocations,
            isH1: product.isH1,
            hsnCode: product.hsnCode,
          ),
        );

      emit(
        state.copyWith(
          status: PosStatus.ready,
          items: updated,
          requiresPrescription: updated.any((item) => item.isH1),
        ),
      );
    } on StateError catch (error) {
      emit(state.copyWith(status: PosStatus.error, error: error.message));
    } catch (_) {
      emit(
        state.copyWith(
          status: PosStatus.error,
          error: 'Unable to add item to cart.',
        ),
      );
    }
  }

  void _onInvoiceDiscountUpdated(
    PosInvoiceDiscountUpdated event,
    Emitter<PosState> emit,
  ) {
    emit(
      state.copyWith(
        invoiceDiscount: (event.discount * 100).round() / 100,
        status: PosStatus.ready,
        error: null,
      ),
    );
  }

  void _onCustomerStateChanged(
    PosCustomerStateChanged event,
    Emitter<PosState> emit,
  ) {
    emit(
      state.copyWith(
        isIntraState: event.isIntraState,
        status: PosStatus.ready,
        error: null,
      ),
    );
  }

  Future<void> _onCheckoutSubmitted(
    PosCheckoutSubmitted event,
    Emitter<PosState> emit,
  ) async {
    final hasH1Item = state.items.any((item) => item.isH1);
    final complianceRepository =
        _complianceRepository ?? ComplianceRepository(database: _database);
    final invoiceRef = 'POS-${DateTime.now().millisecondsSinceEpoch}';

    if (hasH1Item &&
        (event.patientName.trim().isEmpty ||
            event.prescriberName.trim().isEmpty ||
            event.prescriberAddress.trim().isEmpty ||
            event.patientRegistrationNo.trim().isEmpty ||
            event.prescriptionFilePath.trim().isEmpty)) {
      emit(
        state.copyWith(
          status: PosStatus.error,
          error:
              'H1 items require patient, prescriber, and prescription file details before checkout.',
        ),
      );
      return;
    }

    if (hasH1Item &&
        !_isSupportedPrescriptionFile(event.prescriptionFilePath)) {
      emit(
        state.copyWith(
          status: PosStatus.error,
          error:
              'Prescription file must be a PDF or image (.pdf/.jpg/.jpeg/.png).',
        ),
      );
      return;
    }

    if (hasH1Item) {
      final prescription = PrescriptionRecord(
        invoiceNo: invoiceRef,
        patientName: event.patientName.trim(),
        doctorName: event.prescriberName.trim(),
        filePath: event.prescriptionFilePath.trim(),
        uploadedAt: DateTime.now(),
      );
      await complianceRepository.savePrescriptionRecord(
        prescription,
        actor: 'pos',
      );

      for (final item in state.items.where((item) => item.isH1)) {
        final h1 = H1Record(
          invoiceNo: invoiceRef,
          productName: item.name,
          prescriberName: event.prescriberName.trim(),
          prescriberAddress: event.prescriberAddress.trim(),
          patientName: event.patientName.trim(),
          patientRegistrationNo: event.patientRegistrationNo.trim(),
          saleDate: DateTime.now(),
          retentionUntil: DateTime.now().add(const Duration(days: 365 * 3)),
        );
        await complianceRepository.saveH1Record(h1, actor: 'pos');
      }
    }

    for (final item in state.items.where((item) => _isNdpsCandidate(item))) {
      final ndps = NdpsRecord(
        formType: '3E',
        drugName: item.name,
        invoiceNo: invoiceRef,
        openingQty: item.quantity,
        receivedQty: 0,
        dispensedQty: item.quantity,
        closingQty: 0,
        patientName: event.patientName.trim().isEmpty
            ? null
            : event.patientName.trim(),
        notes: 'Auto-entry from POS checkout',
        recordDate: DateTime.now(),
        retentionUntil: DateTime.now().add(const Duration(days: 365 * 2)),
      );
      await complianceRepository.saveNdpsRecord(ndps, actor: 'pos');
    }

    emit(
      state.copyWith(
        status: PosStatus.ready,
        items: const [],
        invoiceDiscount: 0,
        error: null,
        requiresPrescription: false,
      ),
    );
  }

  bool _isNdpsCandidate(PosLineItem item) {
    final normalizedName = item.name.toLowerCase();
    final normalizedHsn = item.hsnCode.toLowerCase();
    return normalizedHsn.contains('ndps') ||
        normalizedName.contains('narcotic') ||
        normalizedName.contains('psychotropic');
  }

  bool _isSupportedPrescriptionFile(String path) {
    final lower = path.trim().toLowerCase();
    return lower.endsWith('.pdf') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png');
  }
}
