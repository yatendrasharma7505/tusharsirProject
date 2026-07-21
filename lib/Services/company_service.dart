import 'package:dio/dio.dart';
import 'api_client.dart';

class CompanyService {
  final Dio _dio = ApiClient.instance.dio;

  Future<List<dynamic>> getCompanies() async {
    final response = await _dio.get('/companies');
    return response.data['companies'] as List<dynamic>;
  }
}
