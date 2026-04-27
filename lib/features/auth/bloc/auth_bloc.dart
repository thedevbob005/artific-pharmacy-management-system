import 'package:equatable/equatable.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/permissions.dart';
import '../../../core/di/service_locator.dart';
import '../repository/auth_repository.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, loading, failure }

class AuthState extends Equatable {
  const AuthState({
    required this.status,
    required this.themeMode,
    this.role,
    this.username,
    this.error,
  });

  const AuthState.initial()
      : status = AuthStatus.unknown,
        themeMode = ThemeMode.system,
        role = null,
        username = null,
        error = null;

  final AuthStatus status;
  final ThemeMode themeMode;
  final UserRole? role;
  final String? username;
  final String? error;

  AuthState copyWith({
    AuthStatus? status,
    ThemeMode? themeMode,
    UserRole? role,
    String? username,
    String? error,
    bool clearUser = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      themeMode: themeMode ?? this.themeMode,
      role: clearUser ? null : role ?? this.role,
      username: clearUser ? null : username ?? this.username,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, themeMode, role, username, error];
}

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthAppStarted extends AuthEvent {
  const AuthAppStarted();
}

final class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested({required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object?> get props => [username, password];
}

final class AuthLoggedOut extends AuthEvent {
  const AuthLoggedOut();
}

final class AuthThemeToggled extends AuthEvent {
  const AuthThemeToggled();
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({AuthRepository? authRepository})
      : _authRepository = authRepository ?? getIt<AuthRepository>(),
        super(const AuthState.initial()) {
    on<AuthAppStarted>(_onStarted);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLoggedOut>(_onLoggedOut);
    on<AuthThemeToggled>(_onThemeToggled);
  }

  final AuthRepository _authRepository;

  void _onStarted(AuthAppStarted event, Emitter<AuthState> emit) {
    emit(state.copyWith(status: AuthStatus.unauthenticated));
  }

  Future<void> _onLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading, error: null));

    final session = await _authRepository.login(
      username: event.username.trim(),
      password: event.password,
    );

    if (session == null) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          error: 'Invalid username or password.',
          clearUser: true,
        ),
      );
      emit(state.copyWith(status: AuthStatus.unauthenticated));
      return;
    }

    emit(
      state.copyWith(
        status: AuthStatus.authenticated,
        username: session.username,
        role: session.role,
        error: null,
      ),
    );
  }

  void _onLoggedOut(AuthLoggedOut event, Emitter<AuthState> emit) {
    emit(state.copyWith(status: AuthStatus.unauthenticated, clearUser: true));
  }

  void _onThemeToggled(AuthThemeToggled event, Emitter<AuthState> emit) {
    final nextMode = state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(state.copyWith(themeMode: nextMode, error: state.error));
  }
}
