import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/company_service.dart';
import 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  final CompanyService _service = CompanyService();

  CompanyCubit() : super(const CompanyState());

  Future<void> loadCompanies() async {
    emit(state.copyWith(status: CompanyStatus.loading, errorMessage: null));
    try {
      final companies = await _service.getCompanies();
      emit(state.copyWith(status: CompanyStatus.loaded, companies: companies));
    } catch (e) {
      emit(state.copyWith(
        status: CompanyStatus.error,
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
