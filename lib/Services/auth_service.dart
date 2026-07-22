import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';

class AuthService {
  final Dio _dio;

  AuthService() : _dio = ApiClient.instance.dio;

  Future<Map<String, dynamic>> login(String identifier, String password) async {
    final response = await _dio.post('/auth/login', data: {
      'identifier': identifier,
      'password': password,
    });

    final data = response.data as Map<String, dynamic>;
    if (data['success'] == true) {
      await _saveToken(data['token'] as String);
      return data['user'] as Map<String, dynamic>;
    }
    throw Exception('Login failed');
  }

  /// Looks up an Employee ID/phone before the password step, so the login
  /// screen knows whether to show "sign in" or the first-time "set password" fields.
  Future<Map<String, dynamic>> checkIdentifier(String identifier) async {
    final response = await _dio.post('/auth/check-identifier', data: {
      'identifier': identifier,
    });
    return response.data as Map<String, dynamic>;
  }

  /// First-login step: the employee (not the admin) chooses their own password here.
  Future<Map<String, dynamic>> setPassword(
    String identifier,
    String password,
    String confirmPassword,
  ) async {
    final response = await _dio.post('/auth/set-password', data: {
      'identifier': identifier,
      'password': password,
      'confirmPassword': confirmPassword,
    });

    final data = response.data as Map<String, dynamic>;
    if (data['success'] == true) {
      await _saveToken(data['token'] as String);
      return data['user'] as Map<String, dynamic>;
    }
    throw Exception('Could not set password');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      return jsonDecode(userJson) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user));
  }
}
