import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../config/di/injector.dart';
import '../../../data/core/data_state.dart';

import '../../../domain/models/meal_builder_item.dart';

import '../../../domain/models/request/log_food_request_model.dart';

import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/token_storage.dart';

import '../../home/provider/get_agenda_provider.dart';

import 'log_meal_state.dart';

final logMealProvider =
StateNotifierProvider<
    LogMealNotifier,
    LogMealState>(
      (ref) =>
      LogMealNotifier(ref),
);

class LogMealNotifier
    extends StateNotifier<
        LogMealState> {

  final Ref ref;

  LogMealNotifier(this.ref)
      : super(
    const LogMealState(),
  );

  final _repo =
  getIt<ApiRepository>();

  final _tokenStorage =
  getIt<TokenStorage>();

  Future<void> logMeal({

    required List<
        MealBuilderItem>
    mealItems,

    required String
    mealType,
  }) async {

    try {

      state = state.copyWith(

        isLoading: true,

        isSuccess: false,

        errorMessage: null,
      );

      final token =
      await _tokenStorage
          .getAccessToken();

      final response =
      await _repo.logMeal(

        token:
        'Bearer $token',

        logFoodRequestModel:
        LogFoodRequestModel(

          mealType:
          mealType,

          items:
          mealItems.map((e) {

            return Items(

              foodName:
              e.foodName,

              imageUrl:
              e.imageUrl,

              calories:
              e.calories,

              protein:
              e.protein,

              carbs:
              e.carbs,

              fat:
              e.fat,

              quantity:
              e.quantity,

              confidence: 0,
            );

          }).toList(),
        ),
      );

      if (response
      is DataSuccess) {

        state = state.copyWith(

          isLoading: false,

          isSuccess: true,
        );

        /// REFRESH HOME

        ref
            .read(
          agendaProvider.notifier,
        )
            .getDailyAgenda();

      } else if (response
      is DataFailed) {

        state = state.copyWith(

          isLoading: false,

          errorMessage:

          response
              .exception
              ?.response
              ?.data['Errors']?[0]
          ?['Message']

              ??

              "Something went wrong",
        );
      }

    } catch (e) {

      state = state.copyWith(

        isLoading: false,

        errorMessage:
        e.toString(),
      );
    }
  }

  void reset() {

    state =
    const LogMealState();
  }
}