import 'package:calorix_app/domain/models/request/log_food_request_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../config/di/injector.dart';
import '../../../data/core/data_state.dart';
import '../../../domain/models/response/food_scan_response_model.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/token_storage.dart';
import '../../home/provider/get_agenda_provider.dart';
import 'log_meal_state.dart';

final logMealProvider =
StateNotifierProvider<LogMealNotifier, LogMealState>(
      (ref) => LogMealNotifier(ref),
);

class LogMealNotifier extends StateNotifier<LogMealState> {
  final Ref ref;

  LogMealNotifier(this.ref) : super(const LogMealState());

  final _repo = getIt<ApiRepository>();
  final _tokenStorage = getIt<TokenStorage>();

  Future<void> logMeal(FoodScanResponseModel data, String mealType, int quantity, int consumedPercentage) async {
    try {
      state = state.copyWith(isLoading: true, isSuccess: false);

      final token = await _tokenStorage.getAccessToken();

      final result = data.result;

      final response = await _repo.logMeal(
        logFoodRequestModel: LogFoodRequestModel(
          imageUrl: result?.imageUrl,
          quantity: quantity,
          consumedPercentage: consumedPercentage,
          foodName: result?.foodName,
          calories: result?.nutrition?.calories,
          protein: result?.nutrition?.protein,
          carbs: result?.nutrition?.carbs,
          fat: result?.nutrition?.fat,
          mealType: mealType,
        ),
        token: 'Bearer $token',
      );

      if (response is DataSuccess) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
        );

        // refresh dashboard silently
        ref.read(agendaProvider.notifier).getDailyAgenda();

      } else if (response is DataFailed) {
        state = state.copyWith(
          isLoading: false,
          errorMessage:
          response.exception?.response?.data['Errors']?[0]?['Message'] ??
              "Something went wrong",
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void reset() {
    state = const LogMealState();
  }
}