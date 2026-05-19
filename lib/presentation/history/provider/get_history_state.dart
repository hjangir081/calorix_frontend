import 'package:calorix_app/domain/models/response/get_history_response_model.dart';

enum MealHistoryStatus {
  initial,
  loading,
  success,
  error,
}

class MealHistoryState {
  final MealHistoryStatus status;
  final GetHistoryResponseModel? data;
  final String? errorMessage;

  const MealHistoryState({
    this.status = MealHistoryStatus.initial,
    this.data,
    this.errorMessage,
  });

  MealHistoryState copyWith({
    MealHistoryStatus? status,
    GetHistoryResponseModel? data,
    String? errorMessage,
  }) {
    return MealHistoryState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage:
      errorMessage ?? this.errorMessage,
    );
  }
}