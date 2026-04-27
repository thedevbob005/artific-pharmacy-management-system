import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/bloc/auth_bloc.dart';

class ApmsApp extends StatelessWidget {
  const ApmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc()..add(const AuthAppStarted()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return FluentApp.router(
            title: 'APMS by Artific',
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
