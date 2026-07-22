enum EmployeeStatus { initial, loading, loaded, error }

class EmployeeState {
  final EmployeeStatus status;
  final Map<String, dynamic>? stats;
  final List<dynamic>? team;
  final String? errorMessage;

  const EmployeeState({
    this.status = EmployeeStatus.initial,
    this.stats,
    this.team,
    this.errorMessage,
  });

  EmployeeState copyWith({
    EmployeeStatus? status,
    Map<String, dynamic>? stats,
    List<dynamic>? team,
    String? errorMessage,
  }) {
    return EmployeeState(
      status: status ?? this.status,
      stats: stats ?? this.stats,
      team: team ?? this.team,
      errorMessage: errorMessage,
    );
  }
}
