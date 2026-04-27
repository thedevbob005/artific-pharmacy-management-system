import 'package:go_router/go_router.dart';

import '../../features/auth/pages/login_page.dart';
import '../../features/shell/pages/app_shell_page.dart';

class AppRouter {
  const AppRouter._();

  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const AppShellPage(),
      ),
    ],
  );
}
