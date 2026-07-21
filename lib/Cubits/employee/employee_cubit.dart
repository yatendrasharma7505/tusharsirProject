import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/employee_service.dart';
import 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeService _service = EmployeeService();

  EmployeeCubit() : super(const EmployeeState());

  Future<void> loadMyStats() async {
    emit(state.copyWith(status: EmployeeStatus.loading, errorMessage: null));
    try {
      final stats = await _service.getMyStats();
      emit(state.copyWith(status: EmployeeStatus.loaded, stats: stats));
    } catch (e) {
      emit(state.copyWith(
        status: EmployeeStatus.error,
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
