import 'package:dio/dio.dart';
import 'api_client.dart';

class NotificationService {
  final Dio _dio = ApiClient.instance.dio;

  Future<Map<String, dynamic>> getNotifications() async {
    final response = await _dio.get('/notifications');
    return response.data as Map<String, dynamic>;
  }

  Future<void> markAsRead(String id) async {
    await _dio.patch('/notifications/$id/read');
  }

  Future<void> markAllAsRead() async {
    await _dio.patch('/notifications/read-all');
  }
}
