enum EmployeeStatus { initial, loading, loaded, error }

class EmployeeState {
  final EmployeeStatus status;
  final Map<String, dynamic>? stats;
  final String? errorMessage;

  const EmployeeState({
    this.status = EmployeeStatus.initial,
    this.stats,
    this.errorMessage,
  });

  EmployeeState copyWith({
    EmployeeStatus? status,
    Map<String, dynamic>? stats,
    String? errorMessage,
  }) {
    return EmployeeState(
      status: status ?? this.status,
      stats: stats ?? this.stats,
      errorMessage: errorMessage,
    );
  }
}
