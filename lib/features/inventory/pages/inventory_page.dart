import 'package:fluent_ui/fluent_ui.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: PageHeader(title: Text('Inventory (Phase 1 Scaffold)')),
      content: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Planned in Phase 1E: product CRUD, batch tracking, stock alerts, and stock adjustment audit trail.',
        ),
      ),
    );
  }
}
