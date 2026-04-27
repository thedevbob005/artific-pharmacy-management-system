import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController(text: 'admin');
  final _passwordController = TextEditingController(text: 'admin123');

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.go('/');
        }
      },
      child: NavigationView(
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
                    const SizedBox(height: 12),
                    const Text('Password'),
                    const SizedBox(height: 8),
                    TextBox(controller: _passwordController, obscureText: true),
                    const SizedBox(height: 16),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state.error != null) {
                          return InfoBar(
                            title: const Text('Login failed'),
                            content: Text(state.error!),
                            severity: InfoBarSeverity.error,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return FilledButton(
                          onPressed: state.status == AuthStatus.loading
                              ? null
                              : () {
                                  context.read<AuthBloc>().add(
                                        AuthLoginRequested(
                                          username: _usernameController.text,
                                          password: _passwordController.text,
                                        ),
                                      );
                                },
                          child: Text(
                            state.status == AuthStatus.loading ? 'Signing in...' : 'Login',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
