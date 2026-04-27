import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/permissions.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../dashboard/pages/dashboard_page.dart';
import '../../inventory/pages/inventory_page.dart';
import '../../pos/pages/pos_page.dart';

class AppShellPage extends StatelessWidget {
  const AppShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final role = authState.role ?? UserRole.admin;
        final access = PermissionMatrix.byRole[role] ?? const <String, ModulePermission>{};

        final entries = <NavigationPaneItem>[];
        if (_canSee(access, 'Billing/POS')) {
          entries.add(
            PaneItem(
              icon: const Icon(FluentIcons.shop),
              title: const Text('POS'),
              body: const PosPage(),
            ),
          );
        }
        if (_canSee(access, 'Inventory')) {
          entries.add(
            PaneItem(
              icon: const Icon(FluentIcons.product_release),
              title: const Text('Inventory'),
              body: const InventoryPage(),
            ),
          );
        }

        return NavigationView(
          pane: NavigationPane(
            selected: 0,
            items: [
              PaneItem(
                icon: const Icon(FluentIcons.view_dashboard),
                title: const Text('Dashboard'),
                body: const DashboardPage(),
              ),
              ...entries,
            ],
          ),
        );
      },
    );
  }

  bool _canSee(Map<String, ModulePermission> access, String module) {
    final permission = access[module] ?? ModulePermission.none;
    return permission != ModulePermission.none;
  }
}
