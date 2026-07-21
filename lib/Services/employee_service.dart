import 'package:dio/dio.dart';
import 'api_client.dart';

class EmployeeService {
  final Dio _dio = ApiClient.instance.dio;

  Future<Map<String, dynamic>> getMyStats() async {
    final response = await _dio.get('/employees/me/stats');
    return response.data['stats'] as Map<String, dynamic>;
  }
}
