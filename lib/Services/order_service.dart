import 'dart:io';
import 'package:dio/dio.dart';
import 'api_client.dart';

class OrderService {
  final Dio _dio = ApiClient.instance.dio;

  Future<Map<String, dynamic>> getOrders({
    String? search,
    String? status,
    String? priority,
    String? employee,
    int page = 1,
    int limit = 20,
  }) async {
    final params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    if (search != null && search.isNotEmpty) params['search'] = search;
    if (status != null) params['status'] = status;
    if (priority != null) params['priority'] = priority;
    if (employee != null) params['employee'] = employee;

    final response = await _dio.get('/orders', queryParameters: params);
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getOrder(String id) async {
    final response = await _dio.get('/orders/$id');
    return response.data['order'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> createOrder(
    Map<String, dynamic> data, {
    File? photo,
    bool force = false,
  }) async {
    final fields = <String, dynamic>{...data, 'force': force.toString()};

    final payload = photo != null
        ? FormData.fromMap({
            ...fields,
            'photo': await MultipartFile.fromFile(photo.path, filename: photo.path.split(Platform.pathSeparator).last),
          })
        : fields;

    final response = await _dio.post('/orders', data: payload);
    return response.data['order'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateStatus(String id, String status) async {
    final response = await _dio.patch('/orders/$id/status', data: {'status': status});
    return response.data['order'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> addComment(String id, String comment) async {
    final response = await _dio.post('/orders/$id/comments', data: {'comment': comment});
    return response.data['order'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> parseWhatsApp(String text) async {
    final response = await _dio.post('/orders/parse-whatsapp', data: {'text': text});
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> checkDuplicate(String phone) async {
    final response = await _dio.get('/orders/check-duplicate', queryParameters: {'phone': phone});
    return response.data as Map<String, dynamic>;
  }
}
