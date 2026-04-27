import 'package:fluent_ui/fluent_ui.dart';

class PosPage extends StatelessWidget {
  const PosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: PageHeader(title: Text('POS / Billing (Phase 1 Scaffold)')),
      content: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Planned in Phase 1D: barcode input, FEFO allocation, GST split, discounts, and payment dialog.',
        ),
      ),
    );
  }
}
