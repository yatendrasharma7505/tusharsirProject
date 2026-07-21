import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/notification_service.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationService _service = NotificationService();

  NotificationCubit() : super(const NotificationState());

  Future<void> loadNotifications() async {
    emit(state.copyWith(status: NotificationStatus.loading, errorMessage: null));
    try {
      final result = await _service.getNotifications();
      emit(state.copyWith(
        status: NotificationStatus.loaded,
        notifications: result['notifications'] as List<dynamic>?,
        unreadCount: result['unreadCount'] as int? ?? 0,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NotificationStatus.error,
        errorMessage: _parseError(e),
      ));
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      await _service.markAsRead(id);
      await loadNotifications();
    } catch (e) {
      emit(state.copyWith(errorMessage: _parseError(e)));
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await _service.markAllAsRead();
      await loadNotifications();
    } catch (e) {
      emit(state.copyWith(errorMessage: _parseError(e)));
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
