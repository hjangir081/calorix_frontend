import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../config/di/injector.dart';
import '../../../data/core/data_state.dart';
import '../../../domain/models/request/update_goal_request_model.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/token_storage.dart';
import 'update_goal_state.dart';

final updateGoalProvider =
StateNotifierProvider<
    UpdateGoalNotifier,
    UpdateGoalState>(
      (ref) =>
      UpdateGoalNotifier(),
);

class UpdateGoalNotifier
    extends StateNotifier<
        UpdateGoalState> {

  UpdateGoalNotifier()
      : super(
    const UpdateGoalState(),
  );

  final _repo =
  getIt<ApiRepository>();

  final _tokenStorage =
  getIt<TokenStorage>();

  Future<void> updateGoal({

    required String goal,

    double? targetWeightChange,

    int? durationValue,

    String? durationUnit,

  }) async {

    try {

      state = state.copyWith(
        status:
        UpdateGoalStatus.loading,
      );

      final token =
      await _tokenStorage
          .getAccessToken();

      if (token == null ||
          token.isEmpty) {

        state = state.copyWith(
          status:
          UpdateGoalStatus.error,

          message:
          'User not authenticated',
        );

        return;
      }

      /// REQUEST MODEL

      final request =
      UpdateGoalRequestModel(

        goal:
        goal,

        /// ONLY FOR LOSE/GAIN

        targetWeightChange:
        goal != 'maintain'
            ? targetWeightChange
            : null,

        durationValue:
        goal != 'maintain'
            ? durationValue
            : null,

        durationUnit:
        goal != 'maintain'
            ? durationUnit
            : null,
      );

      final response =
      await _repo.updateGoal(
        token:
        'Bearer $token',
        updateGoalRequestModel: request,
      );

      if (response
      is DataSuccess) {

        state = state.copyWith(
          status:
          UpdateGoalStatus.success,

          data:
          request,

          message:
          'Goal updated successfully',
        );

      } else if (response
      is DataFailed) {

        state = state.copyWith(
          status:
          UpdateGoalStatus.error,

          message:
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
        UpdateGoalStatus.error,

        message:
        e.toString(),
      );
    }
  }

  void reset() {

    state =
    const UpdateGoalState();
  }
}