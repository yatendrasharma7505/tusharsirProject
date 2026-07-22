import 'package:dio/dio.dart';
import 'api_client.dart';

class EmployeeService {
  final Dio _dio = ApiClient.instance.dio;

  Future<Map<String, dynamic>> getMyStats() async {
    final response = await _dio.get('/employees/me/stats');
    return response.data['stats'] as Map<String, dynamic>;
  }

  /// Own-company roster - used to populate the "Assign to" picker on the
  /// manual add-order screen. The backend locks non-admins to their own
  /// company, so this never returns another company's employees.
  Future<List<dynamic>> listTeam() async {
    final response = await _dio.get('/employees');
    return response.data['employees'] as List<dynamic>;
  }
}
