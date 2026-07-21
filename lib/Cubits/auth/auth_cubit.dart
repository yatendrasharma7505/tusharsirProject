import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService = AuthService();

  AuthCubit() : super(const AuthState());

  Future<void> login(String identifier, String password) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    try {
      final user = await _authService.login(identifier, password);
      final token = await _authService.getToken();
      await _authService.saveUser(user);
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        token: token,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: _parseError(e),
      ));
    }
  }

  Future<void> checkAuth() async {
    final user = await _authService.getUser();
    final token = await _authService.getToken();
    if (user != null && token != null) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        token: token,
      ));
    } else {
      emit(const AuthState(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }

  String _parseError(dynamic e) {
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return data['message'] as String;
      }
      return 'Connection failed. Check your network.';
    }
    return e.toString();
  }
}
