import 'package:fluent_ui/fluent_ui.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pos_bloc.dart';

class PosPage extends StatefulWidget {
  const PosPage({super.key});

  @override
  State<PosPage> createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> {
  final _productIdController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _invoiceDiscountController = TextEditingController(text: '0');
  final _patientController = TextEditingController();
  final _prescriberController = TextEditingController();
  final _prescriberAddressController = TextEditingController();
  final _patientRegController = TextEditingController();
  final _prescriptionPathController = TextEditingController();

  @override
  void dispose() {
    _productIdController.dispose();
    _quantityController.dispose();
    _invoiceDiscountController.dispose();
    _patientController.dispose();
    _prescriberController.dispose();
    _prescriberAddressController.dispose();
    _patientRegController.dispose();
    _prescriptionPathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PosBloc()..add(const PosStarted()),
      child: ScaffoldPage(
        header: const PageHeader(title: Text('POS / Billing')),
        content: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<PosBloc, PosState>(
            builder: (context, state) {
              final bloc = context.read<PosBloc>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: InfoBar(
                        title: const Text('POS validation'),
                        content: Text(state.error!),
                        severity: InfoBarSeverity.error,
                      ),
                    ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          SizedBox(
                            width: 140,
                            child: TextBox(
                              controller: _productIdController,
                              placeholder: 'Product ID',
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: TextBox(
                              controller: _quantityController,
                              placeholder: 'Qty',
                            ),
                          ),
                          FilledButton(
                            onPressed: () {
                              bloc.add(
                                PosItemAdded(
                                  productId:
                                      int.tryParse(_productIdController.text) ??
                                      0,
                                  quantity:
                                      double.tryParse(
                                        _quantityController.text,
                                      ) ??
                                      1,
                                ),
                              );
                            },
                            child: const Text('Add Item'),
                          ),
                          SizedBox(
                            width: 180,
                            child: TextBox(
                              controller: _invoiceDiscountController,
                              placeholder: 'Invoice discount',
                              onChanged: (value) => bloc.add(
                                PosInvoiceDiscountUpdated(
                                  double.tryParse(value) ?? 0,
                                ),
                              ),
                            ),
                          ),
                          ToggleSwitch(
                            content: const Text('Intra-state'),
                            checked: state.isIntraState,
                            onChanged: (value) => bloc.add(
                              PosCustomerStateChanged(isIntraState: value),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Taxable ₹${state.taxableTotal(bloc.taxEngine).toStringAsFixed(2)}  •  Tax ₹${state.taxTotal(bloc.taxEngine).toStringAsFixed(2)}  •  Grand ₹${state.grandTotal(bloc.taxEngine).toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 8),
                  if (state.requiresPrescription)
                    const Text('Checkout requires H1 prescription details.'),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return ListTile.selectable(
                          title: Text(
                            '${item.name} • qty ${item.quantity.toStringAsFixed(2)}',
                          ),
                          subtitle: Text(
                            item.isH1 ? 'Schedule H1 item' : 'Regular item',
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () => _onCheckoutPressed(context, state),
                    child: const Text('Checkout'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onCheckoutPressed(BuildContext context, PosState state) async {
    if (!state.requiresPrescription) {
      context.read<PosBloc>().add(
        const PosCheckoutSubmitted(
          patientName: '',
          prescriberName: '',
          prescriberAddress: '',
          patientRegistrationNo: '',
          prescriptionFilePath: '',
        ),
      );
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return ContentDialog(
          title: const Text('Schedule H1 Compliance Details'),
          content: Column(
            children: [
              TextBox(
                controller: _patientController,
                placeholder: 'Patient name',
              ),
              const SizedBox(height: 8),
              TextBox(
                controller: _prescriberController,
                placeholder: 'Prescriber name',
              ),
              const SizedBox(height: 8),
              TextBox(
                controller: _prescriberAddressController,
                placeholder: 'Prescriber address',
              ),
              const SizedBox(height: 8),
              TextBox(
                controller: _patientRegController,
                placeholder: 'Patient registration no.',
              ),
              const SizedBox(height: 8),
              TextBox(
                controller: _prescriptionPathController,
                placeholder: 'Prescription path (.pdf/.jpg/.jpeg/.png)',
              ),
              const SizedBox(height: 8),
              Button(
                onPressed: () async {
                  final picked = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png'],
                  );
                  final file = picked?.files.single.path;
                  if (file != null) {
                    _prescriptionPathController.text = file;
                  }
                },
                child: const Text('Pick File'),
              ),
            ],
          ),
          actions: [
            Button(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                context.read<PosBloc>().add(
                  PosCheckoutSubmitted(
                    patientName: _patientController.text,
                    prescriberName: _prescriberController.text,
                    prescriberAddress: _prescriberAddressController.text,
                    patientRegistrationNo: _patientRegController.text,
                    prescriptionFilePath: _prescriptionPathController.text,
                  ),
                );
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Confirm Checkout'),
            ),
          ],
        );
      },
    );
  }
}
