import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/leaderboard_service.dart';
import 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  final LeaderboardService _service = LeaderboardService();

  LeaderboardCubit() : super(const LeaderboardState());

  Future<void> loadLeaderboard({String range = 'day'}) async {
    emit(state.copyWith(status: LeaderboardStatus.loading, range: range, errorMessage: null));
    try {
      final result = await _service.getLeaderboard(range: range);
      emit(state.copyWith(
        status: LeaderboardStatus.loaded,
        leaderboard: result['leaderboard'] as List<dynamic>?,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LeaderboardStatus.error,
        errorMessage: _parseError(e),
      ));
    }
  }

  String _parseError(dynamic e) {
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return data['message'] as String;
      }
      return 'Connection failed';
    }
    return e.toString();
  }
}
