import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/login_model.dart';
import '../../data/repositories/auth_repository.dart';
import './auth_bloc_state.dart';

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  void _onLoginButtonPressed(LoginButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await authRepository.login(
        event.loginName,
        event.password,
      );
      
      if (response.isSuccess) {
        emit(AuthAuthenticated(response.alert));
      } else {
        emit(AuthError(response.alert));
      }
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }

  void _onLogoutButtonPressed(LogoutButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.logout();
      emit(AuthInitial());
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }
}
