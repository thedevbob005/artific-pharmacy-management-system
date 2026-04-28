import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../bloc/h1_register_bloc.dart';

class H1RegisterPage extends StatefulWidget {
  const H1RegisterPage({super.key});

  @override
  State<H1RegisterPage> createState() => _H1RegisterPageState();
}

class _H1RegisterPageState extends State<H1RegisterPage> {
  final _invoiceController = TextEditingController();
  final _productController = TextEditingController();
  final _prescriberController = TextEditingController();
  final _prescriberAddressController = TextEditingController();
  final _patientController = TextEditingController();
  final _patientRegistrationController = TextEditingController();

  @override
  void dispose() {
    _invoiceController.dispose();
    _productController.dispose();
    _prescriberController.dispose();
    _prescriberAddressController.dispose();
    _patientController.dispose();
    _patientRegistrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => H1RegisterBloc()..add(const H1RegisterLoaded()),
      child: BlocBuilder<H1RegisterBloc, H1RegisterState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.error != null)
                InfoBar(
                  title: const Text('H1 validation'),
                  content: Text(state.error!),
                  severity: InfoBarSeverity.error,
                ),
              if (state.message != null)
                InfoBar(
                  title: const Text('H1 register'),
                  content: Text(state.message!),
                  severity: InfoBarSeverity.success,
                ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      SizedBox(
                        width: 180,
                        child: TextBox(
                          controller: _invoiceController,
                          placeholder: 'Invoice no.',
                        ),
                      ),
                      SizedBox(
                        width: 220,
                        child: TextBox(
                          controller: _productController,
                          placeholder: 'Product name',
                        ),
                      ),
                      SizedBox(
                        width: 220,
                        child: TextBox(
                          controller: _prescriberController,
                          placeholder: 'Prescriber name',
                        ),
                      ),
                      SizedBox(
                        width: 240,
                        child: TextBox(
                          controller: _prescriberAddressController,
                          placeholder: 'Prescriber address',
                        ),
                      ),
                      SizedBox(
                        width: 220,
                        child: TextBox(
                          controller: _patientController,
                          placeholder: 'Patient name',
                        ),
                      ),
                      SizedBox(
                        width: 220,
                        child: TextBox(
                          controller: _patientRegistrationController,
                          placeholder: 'Patient registration no.',
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          context.read<H1RegisterBloc>().add(
                            H1RegisterEntrySaved(
                              invoiceNo: _invoiceController.text,
                              productName: _productController.text,
                              prescriberName: _prescriberController.text,
                              prescriberAddress:
                                  _prescriberAddressController.text,
                              patientName: _patientController.text,
                              patientRegistrationNo:
                                  _patientRegistrationController.text,
                            ),
                          );
                        },
                        child: const Text('Save H1 Entry'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Button(
                onPressed: () => _printH1Register(state),
                child: const Text('Print H1 Register'),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: state.records.length,
                  itemBuilder: (context, index) {
                    final row = state.records[index];
                    return ListTile.selectable(
                      title: Text(
                        '${row.invoiceNo} • ${row.productName} • ${row.patientName}',
                      ),
                      subtitle: Text(
                        'Doctor: ${row.prescriberName} • Rx retention until ${row.retentionUntil.toLocal().toIso8601String().split('T').first}',
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _printH1Register(H1RegisterState state) async {
    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text('Schedule H1 Register'),
          pw.SizedBox(height: 12),
          pw.TableHelper.fromTextArray(
            headers: const [
              'Invoice',
              'Product',
              'Prescriber',
              'Patient',
              'Patient Reg.',
              'Retention Until',
            ],
            data: state.records
                .map(
                  (row) => [
                    row.invoiceNo,
                    row.productName,
                    row.prescriberName,
                    row.patientName,
                    row.patientRegistrationNo,
                    row.retentionUntil.toIso8601String().split('T').first,
                  ],
                )
                .toList(),
          ),
        ],
      ),
    );
    await Printing.layoutPdf(onLayout: (_) => doc.save());
  }
}
