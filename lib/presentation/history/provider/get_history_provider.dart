import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../config/di/injector.dart';
import '../../../data/core/data_state.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/token_storage.dart';
import 'get_history_state.dart';


final selectedHistoryDateProvider =
StateProvider<DateTime>(
      (ref) => DateTime.now(),
);

final historyDateScrollProvider =
Provider<ScrollController>(
      (ref) {

    return ScrollController(
      initialScrollOffset: 1000,
    );
  },
);

final mealHistoryProvider =
StateNotifierProvider<
    MealHistoryNotifier,
    MealHistoryState>(
      (ref) =>
      MealHistoryNotifier(),
);

class MealHistoryNotifier
    extends StateNotifier<
        MealHistoryState> {

  MealHistoryNotifier()
      : super(
    const MealHistoryState(),
  );

  final _repo =
  getIt<ApiRepository>();

  final _tokenStorage =
  getIt<TokenStorage>();

  Future<void> getMealHistory({
    String? date,
  }) async {

    try {

      state = state.copyWith(
        status:
        MealHistoryStatus.loading,
      );

      final token =
      await _tokenStorage
          .getAccessToken();

      final response =
      await _repo.getHistory(
        token: 'Bearer $token',
        date: date ?? DateTime.now().toIso8601String().split('T')[0],
      );

      if (response
      is DataSuccess) {

        state = state.copyWith(
          status:
          MealHistoryStatus.success,

          data: response.data,

          errorMessage: null,
        );

      } else if (response
      is DataFailed) {

        state = state.copyWith(
          status:
          MealHistoryStatus.error,

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
        MealHistoryStatus.error,

        errorMessage:
        e.toString(),
      );
    }
  }

  void reset() {

    state =
    const MealHistoryState();
  }
}