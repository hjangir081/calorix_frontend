import '../../../domain/models/response/leaderboard_progress_response_model.dart';

enum LeaderboardStatus {
  initial,
  loading,
  success,
  error,
}

class LeaderboardState {

  final LeaderboardStatus status;

  final Result? data;

  final String? errorMessage;

  const LeaderboardState({
    this.status =
        LeaderboardStatus.initial,

    this.data,

    this.errorMessage,
  });

  LeaderboardState copyWith({
    LeaderboardStatus? status,
    Result? data,
    String? errorMessage,
  }) {

    return LeaderboardState(
      status:
      status ?? this.status,

      data:
      data ?? this.data,

      errorMessage:
      errorMessage ??
          this.errorMessage,
    );
  }
}