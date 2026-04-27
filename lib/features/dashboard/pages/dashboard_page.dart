import 'package:fluent_ui/fluent_ui.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: PageHeader(title: Text('Dashboard (Phase 1 Scaffold)')),
      content: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Planned in Phase 1F: KPI cards, alerts, and quick actions.',
        ),
      ),
    );
  }
}
