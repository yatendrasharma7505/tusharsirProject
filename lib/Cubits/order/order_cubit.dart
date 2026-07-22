import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/order_service.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderService _service = OrderService();

  OrderCubit() : super(const OrderState());

  Future<void> loadOrders({
    String? search,
    String? status,
    String? priority,
    String? employee,
    int page = 1,
  }) async {
    emit(state.copyWith(status: OrderStatus.loading, errorMessage: null));
    try {
      final result = await _service.getOrders(
        search: search, status: status, priority: priority, employee: employee, page: page,
      );
      emit(state.copyWith(
        status: OrderStatus.loaded,
        orders: result['orders'] as List<dynamic>?,
        pagination: result['pagination'] as Map<String, dynamic>?,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OrderStatus.error,
        errorMessage: _parseError(e),
      ));
    }
  }

  Future<void> loadOrder(String id) async {
    emit(state.copyWith(status: OrderStatus.loading, errorMessage: null));
    try {
      final order = await _service.getOrder(id);
      emit(state.copyWith(status: OrderStatus.loaded, selectedOrder: order));
    } catch (e) {
      emit(state.copyWith(
        status: OrderStatus.error,
        errorMessage: _parseError(e),
      ));
    }
  }

  Future<void> updateStatus(String id, String status) async {
    try {
      final order = await _service.updateStatus(id, status);
      emit(state.copyWith(selectedOrder: order));
    } catch (e) {
      emit(state.copyWith(errorMessage: _parseError(e)));
    }
  }

  /// Manual "add order" flow. On a 409 duplicate-customer response, [duplicateOrder]
  /// is populated instead of failing outright - call again with `force: true` to save anyway.
  Future<void> createOrder(Map<String, dynamic> data, {File? photo, bool force = false}) async {
    emit(state.copyWith(creating: true, createError: null, duplicateOrder: null));
    try {
      final order = await _service.createOrder(data, photo: photo, force: force);
      emit(state.copyWith(creating: false, createdOrder: order));
    } on DioException catch (e) {
      final responseData = e.response?.data;
      if (e.response?.statusCode == 409 && responseData is Map && responseData['duplicate'] == true) {
        emit(state.copyWith(creating: false, duplicateOrder: responseData['order'] as Map<String, dynamic>?));
      } else {
        emit(state.copyWith(creating: false, createError: _parseError(e)));
      }
    } catch (e) {
      emit(state.copyWith(creating: false, createError: e.toString()));
    }
  }

  void resetCreateState() {
    emit(state.copyWith(creating: false, createError: null, duplicateOrder: null, createdOrder: null));
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
