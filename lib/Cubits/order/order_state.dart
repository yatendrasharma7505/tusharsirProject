enum OrderStatus { initial, loading, loaded, error }

class OrderState {
  final OrderStatus status;
  final List<dynamic>? orders;
  final Map<String, dynamic>? pagination;
  final Map<String, dynamic>? selectedOrder;
  final String? errorMessage;

  // Manual "add order" flow (AddOrderManualscreen) - kept separate from the
  // list/detail fields above so submitting a new order never clobbers them.
  final bool creating;
  final Map<String, dynamic>? createdOrder;
  final Map<String, dynamic>? duplicateOrder;
  final String? createError;

  const OrderState({
    this.status = OrderStatus.initial,
    this.orders,
    this.pagination,
    this.selectedOrder,
    this.errorMessage,
    this.creating = false,
    this.createdOrder,
    this.duplicateOrder,
    this.createError,
  });

  OrderState copyWith({
    OrderStatus? status,
    List<dynamic>? orders,
    Map<String, dynamic>? pagination,
    Map<String, dynamic>? selectedOrder,
    String? errorMessage,
    bool? creating,
    Map<String, dynamic>? createdOrder,
    Map<String, dynamic>? duplicateOrder,
    String? createError,
  }) {
    return OrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      pagination: pagination ?? this.pagination,
      selectedOrder: selectedOrder ?? this.selectedOrder,
      errorMessage: errorMessage,
      creating: creating ?? this.creating,
      createdOrder: createdOrder,
      duplicateOrder: duplicateOrder,
      createError: createError,
    );
  }
}
