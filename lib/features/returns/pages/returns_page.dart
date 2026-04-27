import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/returns_bloc.dart';

class ReturnsPage extends StatefulWidget {
  const ReturnsPage({super.key});

  @override
  State<ReturnsPage> createState() => _ReturnsPageState();
}

class _ReturnsPageState extends State<ReturnsPage> {
  final _invoiceController = TextEditingController();
  final _productController = TextEditingController();
  final _batchController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _unitPriceController = TextEditingController(text: '0');
  final _taxRateController = TextEditingController(text: '12');

  DateTime _invoiceDate = DateTime.now().subtract(const Duration(days: 2));
  DateTime _returnDate = DateTime.now();

  @override
  void dispose() {
    _invoiceController.dispose();
    _productController.dispose();
    _batchController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _taxRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReturnsBloc()..add(const ReturnsStarted()),
      child: ScaffoldPage(
        header: const PageHeader(title: Text('Returns & Credit Notes')),
        content: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<ReturnsBloc, ReturnsState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InfoBar(
                        title: const Text('Return validation error'),
                        content: Text(state.error!),
                        severity: InfoBarSeverity.error,
                      ),
                    ),
                  if (state.message != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InfoBar(
                        title: const Text('Credit note generated'),
                        content: Text(state.message!),
                        severity: InfoBarSeverity.success,
                      ),
                    ),
                  _ReturnHeader(
                    invoiceController: _invoiceController,
                    invoiceDate: _invoiceDate,
                    returnDate: _returnDate,
                    onInvoiceDateChanged: (d) =>
                        setState(() => _invoiceDate = d),
                    onReturnDateChanged: (d) => setState(() => _returnDate = d),
                    onGenerate: () {
                      context.read<ReturnsBloc>().add(
                        CreditNoteGenerated(
                          originalInvoiceNo: _invoiceController.text,
                          originalInvoiceDate: _invoiceDate,
                          returnDate: _returnDate,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _ReturnLineForm(
                    productController: _productController,
                    batchController: _batchController,
                    quantityController: _quantityController,
                    unitPriceController: _unitPriceController,
                    taxRateController: _taxRateController,
                    onAdd: () {
                      context.read<ReturnsBloc>().add(
                        ReturnLineAdded(
                          productName: _productController.text,
                          batchNumber: _batchController.text,
                          quantity:
                              double.tryParse(_quantityController.text) ?? 0,
                          unitPrice:
                              double.tryParse(_unitPriceController.text) ?? 0,
                          taxRate:
                              double.tryParse(_taxRateController.text) ?? 0,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Credit value: ₹${state.creditValue.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 12),
                  Expanded(child: _ReturnLines(lines: state.lines)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ReturnHeader extends StatelessWidget {
  const _ReturnHeader({
    required this.invoiceController,
    required this.invoiceDate,
    required this.returnDate,
    required this.onInvoiceDateChanged,
    required this.onReturnDateChanged,
    required this.onGenerate,
  });

  final TextEditingController invoiceController;
  final DateTime invoiceDate;
  final DateTime returnDate;
  final ValueChanged<DateTime> onInvoiceDateChanged;
  final ValueChanged<DateTime> onReturnDateChanged;
  final VoidCallback onGenerate;

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
              width: 220,
              child: TextBox(
                controller: invoiceController,
                placeholder: 'Original invoice no.',
              ),
            ),
            DatePicker(
              selected: invoiceDate,
              onChanged: (d) => onInvoiceDateChanged(d),
            ),
            DatePicker(
              selected: returnDate,
              onChanged: (d) => onReturnDateChanged(d),
            ),
            FilledButton(
              onPressed: onGenerate,
              child: const Text('Generate credit note'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReturnLineForm extends StatelessWidget {
  const _ReturnLineForm({
    required this.productController,
    required this.batchController,
    required this.quantityController,
    required this.unitPriceController,
    required this.taxRateController,
    required this.onAdd,
  });

  final TextEditingController productController;
  final TextEditingController batchController;
  final TextEditingController quantityController;
  final TextEditingController unitPriceController;
  final TextEditingController taxRateController;
  final VoidCallback onAdd;

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
                controller: unitPriceController,
                placeholder: 'Unit price',
              ),
            ),
            SizedBox(
              width: 80,
              child: TextBox(
                controller: taxRateController,
                placeholder: 'GST %',
              ),
            ),
            FilledButton(
              onPressed: onAdd,
              child: const Text('Add return line'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReturnLines extends StatelessWidget {
  const _ReturnLines({required this.lines});

  final List<ReturnLine> lines;

  @override
  Widget build(BuildContext context) {
    if (lines.isEmpty) {
      return const Center(child: Text('No return lines yet.'));
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
              '${line.productName} • Batch ${line.batchNumber} • Qty ${line.quantity.toStringAsFixed(2)} • Refund ₹${line.total.toStringAsFixed(2)}',
            ),
          ),
        );
      },
    );
  }
}
