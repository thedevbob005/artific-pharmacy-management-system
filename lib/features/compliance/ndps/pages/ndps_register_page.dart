import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../bloc/ndps_register_bloc.dart';

class NdpsRegisterPage extends StatefulWidget {
  const NdpsRegisterPage({super.key});

  @override
  State<NdpsRegisterPage> createState() => _NdpsRegisterPageState();
}

class _NdpsRegisterPageState extends State<NdpsRegisterPage> {
  final _formTypeController = TextEditingController(text: '3D');
  final _drugController = TextEditingController();
  final _invoiceController = TextEditingController();
  final _openingController = TextEditingController(text: '0');
  final _receivedController = TextEditingController(text: '0');
  final _dispensedController = TextEditingController(text: '0');
  final _patientController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _formTypeController.dispose();
    _drugController.dispose();
    _invoiceController.dispose();
    _openingController.dispose();
    _receivedController.dispose();
    _dispensedController.dispose();
    _patientController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NdpsRegisterBloc()..add(const NdpsRegisterLoaded()),
      child: BlocBuilder<NdpsRegisterBloc, NdpsRegisterState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.error != null)
                InfoBar(
                  title: const Text('NDPS validation'),
                  content: Text(state.error!),
                  severity: InfoBarSeverity.error,
                ),
              if (state.message != null)
                InfoBar(
                  title: const Text('NDPS register'),
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
                        width: 80,
                        child: TextBox(
                          controller: _formTypeController,
                          placeholder: '3D/3E/3H',
                        ),
                      ),
                      SizedBox(
                        width: 220,
                        child: TextBox(
                          controller: _drugController,
                          placeholder: 'Drug name',
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: TextBox(
                          controller: _invoiceController,
                          placeholder: 'Invoice no.',
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: TextBox(
                          controller: _openingController,
                          placeholder: 'Opening',
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: TextBox(
                          controller: _receivedController,
                          placeholder: 'Received',
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: TextBox(
                          controller: _dispensedController,
                          placeholder: 'Dispensed',
                        ),
                      ),
                      SizedBox(
                        width: 220,
                        child: TextBox(
                          controller: _patientController,
                          placeholder: 'Patient name (for 3E)',
                        ),
                      ),
                      SizedBox(
                        width: 240,
                        child: TextBox(
                          controller: _notesController,
                          placeholder: 'Notes',
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          context.read<NdpsRegisterBloc>().add(
                            NdpsRegisterEntrySaved(
                              formType: _formTypeController.text,
                              drugName: _drugController.text,
                              invoiceNo: _invoiceController.text,
                              openingQty:
                                  double.tryParse(_openingController.text) ?? 0,
                              receivedQty:
                                  double.tryParse(_receivedController.text) ??
                                  0,
                              dispensedQty:
                                  double.tryParse(_dispensedController.text) ??
                                  0,
                              patientName: _patientController.text,
                              notes: _notesController.text,
                            ),
                          );
                        },
                        child: const Text('Save NDPS Entry'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Button(
                onPressed: () => _printNdpsRegister(state),
                child: const Text('Print NDPS Register'),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: state.records.length,
                  itemBuilder: (context, index) {
                    final row = state.records[index];
                    return ListTile.selectable(
                      title: Text(
                        '${row.formType} • ${row.drugName} • ${row.invoiceNo}',
                      ),
                      subtitle: Text(
                        'Opening ${row.openingQty.toStringAsFixed(2)} • Received ${row.receivedQty.toStringAsFixed(2)} • Dispensed ${row.dispensedQty.toStringAsFixed(2)} • Closing ${row.closingQty.toStringAsFixed(2)}',
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

  Future<void> _printNdpsRegister(NdpsRegisterState state) async {
    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text('NDPS Register (3D / 3E / 3H)'),
          pw.SizedBox(height: 12),
          pw.TableHelper.fromTextArray(
            headers: const [
              'Form',
              'Drug',
              'Invoice',
              'Opening',
              'Received',
              'Dispensed',
              'Closing',
              'Patient',
            ],
            data: state.records
                .map(
                  (row) => [
                    row.formType,
                    row.drugName,
                    row.invoiceNo,
                    row.openingQty.toStringAsFixed(2),
                    row.receivedQty.toStringAsFixed(2),
                    row.dispensedQty.toStringAsFixed(2),
                    row.closingQty.toStringAsFixed(2),
                    row.patientName ?? '',
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
