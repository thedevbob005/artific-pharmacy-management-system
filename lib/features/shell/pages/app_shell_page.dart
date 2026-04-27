import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/permissions.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../contacts/pages/contacts_page.dart';
import '../../customers/pages/customers_page.dart';
import '../../dashboard/pages/dashboard_page.dart';
import '../../inventory/pages/inventory_page.dart';
import '../../pos/pages/pos_page.dart';
import '../../purchases/pages/purchases_page.dart';
import '../../returns/pages/returns_page.dart';

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
        if (_canSee(access, 'Purchases')) {
          entries.add(
            PaneItem(
              icon: const Icon(FluentIcons.receipt_forward),
              title: const Text('Purchases'),
              body: const PurchasesPage(),
            ),
          );
          entries.add(
            PaneItem(
              icon: const Icon(FluentIcons.contact_list),
              title: const Text('Contacts'),
              body: const ContactsPage(),
            ),
          );
        }
        if (_canSee(access, 'Returns')) {
          entries.add(
            PaneItem(
              icon: const Icon(FluentIcons.return_to_session),
              title: const Text('Returns'),
              body: const ReturnsPage(),
            ),
          );
        }
        if (_canSee(access, 'Customers')) {
          entries.add(
            PaneItem(
              icon: const Icon(FluentIcons.people),
              title: const Text('Customers'),
              body: const CustomersPage(),
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
