enum OrderStatus { initial, loading, loaded, error }

class OrderState {
  final OrderStatus status;
  final List<dynamic>? orders;
  final Map<String, dynamic>? pagination;
  final Map<String, dynamic>? selectedOrder;
  final String? errorMessage;

  const OrderState({
    this.status = OrderStatus.initial,
    this.orders,
    this.pagination,
    this.selectedOrder,
    this.errorMessage,
  });

  OrderState copyWith({
    OrderStatus? status,
    List<dynamic>? orders,
    Map<String, dynamic>? pagination,
    Map<String, dynamic>? selectedOrder,
    String? errorMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      pagination: pagination ?? this.pagination,
      selectedOrder: selectedOrder ?? this.selectedOrder,
      errorMessage: errorMessage,
    );
  }
}
