import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/purchases_bloc.dart';

class PurchasesPage extends StatefulWidget {
  const PurchasesPage({super.key});

  @override
  State<PurchasesPage> createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage> {
  final _supplierController = TextEditingController();
  final _gstinController = TextEditingController();
  final _productController = TextEditingController();
  final _batchController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _purchasePriceController = TextEditingController(text: '0');
  final _gstRateController = TextEditingController(text: '12');

  DateTime _expiryDate = DateTime.now().add(const Duration(days: 365));

  @override
  void dispose() {
    _supplierController.dispose();
    _gstinController.dispose();
    _productController.dispose();
    _batchController.dispose();
    _quantityController.dispose();
    _purchasePriceController.dispose();
    _gstRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PurchasesBloc()..add(const PurchasesStarted()),
      child: ScaffoldPage(
        header: const PageHeader(title: Text('Purchases')),
        content: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<PurchasesBloc, PurchasesState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InfoBar(
                        title: const Text('Purchase error'),
                        content: Text(state.error!),
                        severity: InfoBarSeverity.error,
                      ),
                    ),
                  if (state.savedMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InfoBar(
                        title: const Text('Purchase saved'),
                        content: Text(state.savedMessage!),
                        severity: InfoBarSeverity.success,
                      ),
                    ),
                  _PurchaseHeaderCard(
                    supplierController: _supplierController,
                    gstinController: _gstinController,
                    onSave: () {
                      context.read<PurchasesBloc>().add(
                        PurchaseInvoiceSaved(
                          supplierName: _supplierController.text,
                          supplierGstin: _gstinController.text,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _PurchaseLineForm(
                    productController: _productController,
                    batchController: _batchController,
                    quantityController: _quantityController,
                    purchasePriceController: _purchasePriceController,
                    gstRateController: _gstRateController,
                    expiryDate: _expiryDate,
                    onExpiryChanged: (date) =>
                        setState(() => _expiryDate = date),
                    onAdd: () {
                      context.read<PurchasesBloc>().add(
                        PurchaseLineAdded(
                          productName: _productController.text,
                          batchNumber: _batchController.text,
                          quantity:
                              double.tryParse(_quantityController.text) ?? 0,
                          purchasePrice:
                              double.tryParse(_purchasePriceController.text) ??
                              0,
                          gstRate:
                              double.tryParse(_gstRateController.text) ?? 0,
                          expiryDate: _expiryDate,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Taxable: ₹${state.taxableTotal.toStringAsFixed(2)}  •  GST: ₹${state.gstTotal.toStringAsFixed(2)}  •  Invoice Total: ₹${state.invoiceTotal.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 12),
                  Expanded(child: _PurchaseLinesTable(lines: state.lines)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PurchaseHeaderCard extends StatelessWidget {
  const _PurchaseHeaderCard({
    required this.supplierController,
    required this.gstinController,
    required this.onSave,
  });

  final TextEditingController supplierController;
  final TextEditingController gstinController;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: 260,
              child: TextBox(
                controller: supplierController,
                placeholder: 'Supplier name',
              ),
            ),
            SizedBox(
              width: 220,
              child: TextBox(
                controller: gstinController,
                placeholder: 'Supplier GSTIN',
              ),
            ),
            FilledButton(
              onPressed: onSave,
              child: const Text('Save purchase invoice'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PurchaseLineForm extends StatelessWidget {
  const _PurchaseLineForm({
    required this.productController,
    required this.batchController,
    required this.quantityController,
    required this.purchasePriceController,
    required this.gstRateController,
    required this.expiryDate,
    required this.onExpiryChanged,
    required this.onAdd,
  });

  final TextEditingController productController;
  final TextEditingController batchController;
  final TextEditingController quantityController;
  final TextEditingController purchasePriceController;
  final TextEditingController gstRateController;
  final DateTime expiryDate;
  final ValueChanged<DateTime> onExpiryChanged;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 220,
              child: TextBox(
                controller: productController,
                placeholder: 'Product name',
              ),
            ),
            SizedBox(
              width: 120,
              child: TextBox(
                controller: batchController,
                placeholder: 'Batch no.',
              ),
            ),
            SizedBox(
              width: 100,
              child: TextBox(
                controller: quantityController,
                placeholder: 'Qty',
              ),
            ),
            SizedBox(
              width: 120,
              child: TextBox(
                controller: purchasePriceController,
                placeholder: 'Purchase price',
              ),
            ),
            SizedBox(
              width: 80,
              child: TextBox(
                controller: gstRateController,
                placeholder: 'GST %',
              ),
            ),
            DatePicker(
              selected: expiryDate,
              onChanged: (d) => onExpiryChanged(d),
            ),
            FilledButton(onPressed: onAdd, child: const Text('Add line')),
          ],
        ),
      ),
    );
  }
}

class _PurchaseLinesTable extends StatelessWidget {
  const _PurchaseLinesTable({required this.lines});

  final List<PurchaseLine> lines;

  @override
  Widget build(BuildContext context) {
    if (lines.isEmpty) {
      return const Center(child: Text('No purchase lines yet.'));
    }

    return ListView.separated(
      itemCount: lines.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final line = lines[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              '${line.productName} • Batch ${line.batchNumber} • Qty ${line.quantity.toStringAsFixed(2)} • Total ₹${line.total.toStringAsFixed(2)}',
            ),
          ),
        );
      },
    );
  }
}
