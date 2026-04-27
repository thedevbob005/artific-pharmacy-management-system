import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/permissions.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController(text: 'admin');

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      content: ScaffoldPage.scrollable(
        header: const PageHeader(title: Text('APMS Login')),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Username'),
                  const SizedBox(height: 8),
                  TextBox(controller: _usernameController),
                  const SizedBox(height: 16),
                  const Text('Phase 1 scaffold uses seeded Admin role for login.'),
                  const SizedBox(height: 16),
                  FilledButton(
                    child: const Text('Login as Admin'),
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            AuthLoggedIn(
                              username: _usernameController.text.trim(),
                              role: UserRole.admin,
                            ),
                          );
                      context.go('/');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
