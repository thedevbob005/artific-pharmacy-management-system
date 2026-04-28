import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/prescriptions_bloc.dart';

class PrescriptionsPage extends StatefulWidget {
  const PrescriptionsPage({super.key});

  @override
  State<PrescriptionsPage> createState() => _PrescriptionsPageState();
}

class _PrescriptionsPageState extends State<PrescriptionsPage> {
  final _invoiceController = TextEditingController();
  final _patientController = TextEditingController();
  final _doctorController = TextEditingController();
  final _fileController = TextEditingController();

  @override
  void dispose() {
    _invoiceController.dispose();
    _patientController.dispose();
    _doctorController.dispose();
    _fileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PrescriptionsBloc()..add(const PrescriptionsLoaded()),
      child: BlocBuilder<PrescriptionsBloc, PrescriptionsState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.error != null)
                InfoBar(
                  title: const Text('Prescription validation'),
                  content: Text(state.error!),
                  severity: InfoBarSeverity.error,
                ),
              if (state.message != null)
                InfoBar(
                  title: const Text('Prescription register'),
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
                          controller: _patientController,
                          placeholder: 'Patient name',
                        ),
                      ),
                      SizedBox(
                        width: 220,
                        child: TextBox(
                          controller: _doctorController,
                          placeholder: 'Doctor name',
                        ),
                      ),
                      SizedBox(
                        width: 340,
                        child: TextBox(
                          controller: _fileController,
                          placeholder:
                              'Prescription file path (.pdf/.jpg/.jpeg/.png)',
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          context.read<PrescriptionsBloc>().add(
                            PrescriptionSaved(
                              invoiceNo: _invoiceController.text,
                              patientName: _patientController.text,
                              doctorName: _doctorController.text,
                              filePath: _fileController.text,
                            ),
                          );
                        },
                        child: const Text('Link Prescription'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: state.records.length,
                  itemBuilder: (context, index) {
                    final row = state.records[index];
                    return ListTile.selectable(
                      title: Text(
                        '${row.invoiceNo} • ${row.patientName} • ${row.doctorName}',
                      ),
                      subtitle: Text('File: ${row.filePath}'),
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
}
