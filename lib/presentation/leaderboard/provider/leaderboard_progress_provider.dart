import 'package:flutter_riverpod/legacy.dart';
import '../../../config/di/injector.dart';
import '../../../data/core/data_state.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/token_storage.dart';
import 'leaderboard_progress_state.dart';

final leaderboardProvider =
StateNotifierProvider<
    LeaderboardNotifier,
    LeaderboardState>(
      (ref) =>
      LeaderboardNotifier(),
);

class LeaderboardNotifier
    extends StateNotifier<
        LeaderboardState> {

  LeaderboardNotifier()
      : super(
    const LeaderboardState(),
  );

  final _repo =
  getIt<ApiRepository>();

  final _tokenStorage =
  getIt<TokenStorage>();

  Future<void> getLeaderboard({
    int periodDays = 7,
  }) async {

    try {

      state = state.copyWith(
        status:
        LeaderboardStatus.loading,
      );

      final token =
      await _tokenStorage
          .getAccessToken();

      if (token == null ||
          token.isEmpty) {

        state = state.copyWith(
          status:
          LeaderboardStatus.error,

          errorMessage:
          'User not authenticated',
        );

        return;
      }

      final response =
      await _repo.leaderboardProgress(
        token:
        'Bearer $token',
        days: periodDays.toString(),
      );

      if (response
      is DataSuccess) {

        state = state.copyWith(
          status:
          LeaderboardStatus.success,

          data:
          response.data?.result,

          errorMessage:
          null,
        );

      } else if (response
      is DataFailed) {

        state = state.copyWith(
          status:
          LeaderboardStatus.error,

          errorMessage:
          response.exception
              ?.response
              ?.data['Errors']?[0]
          ?['Message'] ??
              'Something went wrong',
        );
      }

    } catch (e) {

      state = state.copyWith(
        status:
        LeaderboardStatus.error,

        errorMessage:
        e.toString(),
      );
    }
  }

  void reset() {

    state =
    const LeaderboardState();
  }
}