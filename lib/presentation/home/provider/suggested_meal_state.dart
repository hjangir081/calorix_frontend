import '../../../domain/models/response/suggest_meal_response_model.dart';

enum SuggestedMealStatus {
  initial,
  loading,
  success,
  error,
}

class SuggestedMealState {
  final SuggestedMealStatus status;

  final SuggestMealResponseModel?
  suggestedMeals;

  final String? errorMessage;

  const SuggestedMealState({
    this.status =
        SuggestedMealStatus.initial,
    this.suggestedMeals,
    this.errorMessage,
  });

  SuggestedMealState copyWith({
    SuggestedMealStatus? status,
    SuggestMealResponseModel?
    suggestedMeals,
    String? errorMessage,
  }) {
    return SuggestedMealState(
      status: status ?? this.status,
      suggestedMeals:
      suggestedMeals ??
          this.suggestedMeals,
      errorMessage:
      errorMessage ??
          this.errorMessage,
    );
  }
}