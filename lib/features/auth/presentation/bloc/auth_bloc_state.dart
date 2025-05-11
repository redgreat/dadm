import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String message;

  const AuthAuthenticated(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthError extends AuthState {
  final String error;

  const AuthError(this.error);

  @override
  List<Object?> get props => [error];
}

// Auth Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends AuthEvent {
  final String loginName;
  final String password;

  const LoginButtonPressed({
    required this.loginName,
    required this.password,
  });

  @override
  List<Object?> get props => [loginName, password];
}

class LogoutButtonPressed extends AuthEvent {}
