import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../config/di/injector.dart';
import '../../../data/core/data_state.dart';
import '../../../domain/models/response/suggest_meal_response_model.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/token_storage.dart';
import 'suggested_meal_state.dart';

final suggestedMealProvider = StateNotifierProvider<
    SuggestedMealNotifier,
    SuggestedMealState>(
      (ref) => SuggestedMealNotifier(
    getIt<ApiRepository>(),
    getIt<TokenStorage>(),
  ),
);

class SuggestedMealNotifier
    extends StateNotifier<SuggestedMealState> {
  final ApiRepository _repository;
  final TokenStorage _tokenStorage;

  SuggestedMealNotifier(
      this._repository,
      this._tokenStorage,
      ) : super(
    const SuggestedMealState(),
  );

  Future<void> getSuggestedMeals() async {
    state = state.copyWith(
      status: SuggestedMealStatus.loading,
    );

    try {
      final token =
      await _tokenStorage.getAccessToken();

      final result =
      await _repository.suggestMeal(
        token: 'Bearer $token',
      );

      if (result is DataSuccess<
          SuggestMealResponseModel>) {
        state = state.copyWith(
          status: SuggestedMealStatus.success,
          suggestedMeals: result.data,
        );
      } else {
        state = state.copyWith(
          status: SuggestedMealStatus.error,
          errorMessage:
          result.exception?.toString(),
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: SuggestedMealStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  void reset() {
    state = const SuggestedMealState();
  }
}