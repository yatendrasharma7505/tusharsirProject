import 'package:dio/dio.dart';
import 'api_client.dart';

class DashboardService {
  final Dio _dio = ApiClient.instance.dio;

  Future<Map<String, dynamic>> getEmployeeDashboard() async {
    final response = await _dio.get('/dashboard/employee');
    return response.data as Map<String, dynamic>;
  }
}
