enum LeaderboardStatus { initial, loading, loaded, error }

class LeaderboardState {
  final LeaderboardStatus status;
  final List<dynamic>? leaderboard;
  final String range;
  final String? errorMessage;

  const LeaderboardState({
    this.status = LeaderboardStatus.initial,
    this.leaderboard,
    this.range = 'day',
    this.errorMessage,
  });

  LeaderboardState copyWith({
    LeaderboardStatus? status,
    List<dynamic>? leaderboard,
    String? range,
    String? errorMessage,
  }) {
    return LeaderboardState(
      status: status ?? this.status,
      leaderboard: leaderboard ?? this.leaderboard,
      range: range ?? this.range,
      errorMessage: errorMessage,
    );
  }
}
