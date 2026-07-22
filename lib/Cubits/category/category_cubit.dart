import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/category_service.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryService _service = CategoryService();

  CategoryCubit() : super(const CategoryState());

  Future<void> loadCategories() async {
    emit(state.copyWith(status: CategoryStatus.loading, errorMessage: null));
    try {
      final categories = await _service.getCategories();
      emit(state.copyWith(status: CategoryStatus.loaded, categories: categories));
    } catch (e) {
      emit(state.copyWith(
        status: CategoryStatus.error,
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
