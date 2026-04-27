import 'package:equatable/equatable.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/permissions.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  const AuthState({
    required this.status,
    required this.themeMode,
    this.role,
    this.username,
  });

  const AuthState.initial()
      : status = AuthStatus.unknown,
        themeMode = ThemeMode.system,
        role = null,
        username = null;

  final AuthStatus status;
  final ThemeMode themeMode;
  final UserRole? role;
  final String? username;

  AuthState copyWith({
    AuthStatus? status,
    ThemeMode? themeMode,
    UserRole? role,
    String? username,
    bool clearUser = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      themeMode: themeMode ?? this.themeMode,
      role: clearUser ? null : role ?? this.role,
      username: clearUser ? null : username ?? this.username,
    );
  }

  @override
  List<Object?> get props => [status, themeMode, role, username];
}

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthAppStarted extends AuthEvent {
  const AuthAppStarted();
}

final class AuthLoggedIn extends AuthEvent {
  const AuthLoggedIn({required this.username, required this.role});

  final String username;
  final UserRole role;

  @override
  List<Object?> get props => [username, role];
}

final class AuthLoggedOut extends AuthEvent {
  const AuthLoggedOut();
}

final class AuthThemeToggled extends AuthEvent {
  const AuthThemeToggled();
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.initial()) {
    on<AuthAppStarted>(_onStarted);
    on<AuthLoggedIn>(_onLoggedIn);
    on<AuthLoggedOut>(_onLoggedOut);
    on<AuthThemeToggled>(_onThemeToggled);
  }

  void _onStarted(AuthAppStarted event, Emitter<AuthState> emit) {
    emit(state.copyWith(status: AuthStatus.unauthenticated));
  }

  void _onLoggedIn(AuthLoggedIn event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        status: AuthStatus.authenticated,
        username: event.username,
        role: event.role,
      ),
    );
  }

  void _onLoggedOut(AuthLoggedOut event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(status: AuthStatus.unauthenticated, clearUser: true),
    );
  }

  void _onThemeToggled(AuthThemeToggled event, Emitter<AuthState> emit) {
    final nextMode = state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    emit(state.copyWith(themeMode: nextMode));
  }
}
