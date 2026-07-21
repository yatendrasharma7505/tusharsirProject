import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/dashboard_service.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardService _service = DashboardService();

  DashboardCubit() : super(const DashboardState());

  Future<void> loadDashboard() async {
    emit(state.copyWith(status: DashboardStatus.loading, errorMessage: null));
    try {
      final data = await _service.getEmployeeDashboard();
      emit(state.copyWith(status: DashboardStatus.loaded, data: data));
    } catch (e) {
      emit(state.copyWith(
        status: DashboardStatus.error,
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
