import 'package:dio/dio.dart';
import 'api_client.dart';

class CategoryService {
  final Dio _dio = ApiClient.instance.dio;

  Future<List<dynamic>> getCategories() async {
    final response = await _dio.get('/categories');
    return response.data['categories'] as List<dynamic>;
  }
}
