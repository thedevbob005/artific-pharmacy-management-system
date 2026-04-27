import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/dashboard_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc()..add(const DashboardStarted()),
      child: ScaffoldPage(
        header: const PageHeader(title: Text('Dashboard')),
        content: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state.status == DashboardStatus.loading) {
                return const Center(child: ProgressRing());
              }
              if (state.status == DashboardStatus.error) {
                return InfoBar(
                  title: const Text('Dashboard error'),
                  content: Text(state.error ?? 'Unknown error'),
                  severity: InfoBarSeverity.error,
                );
              }

              final metrics = state.metrics;
              if (metrics == null) {
                return const Text('No metrics available yet.');
              }

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _KpiCard(title: "Today's Sales", value: '₹${metrics.todaysSales.toStringAsFixed(2)}'),
                  _KpiCard(title: 'Low Stock Products', value: '${metrics.lowStockProducts}'),
                  _KpiCard(title: 'Expiring in 30 days', value: '${metrics.expiringSoonBatches}'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: FluentTheme.of(context).typography.caption),
              const SizedBox(height: 8),
              Text(value, style: FluentTheme.of(context).typography.title),
            ],
          ),
        ),
      ),
    );
  }
}
