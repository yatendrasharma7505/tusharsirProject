import 'package:dio/dio.dart';
import 'api_client.dart';

class LeaderboardService {
  final Dio _dio = ApiClient.instance.dio;

  Future<Map<String, dynamic>> getLeaderboard({String range = 'day'}) async {
    final response = await _dio.get('/leaderboard', queryParameters: {'range': range});
    return response.data as Map<String, dynamic>;
  }
}
