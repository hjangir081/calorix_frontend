import '../../../domain/models/request/update_goal_request_model.dart';

enum UpdateGoalStatus {
  initial,
  loading,
  success,
  error,
}

class UpdateGoalState {

  final UpdateGoalStatus status;

  final String? message;

  final UpdateGoalRequestModel? data;

  const UpdateGoalState({
    this.status =
        UpdateGoalStatus.initial,

    this.message,

    this.data,
  });

  UpdateGoalState copyWith({
    UpdateGoalStatus? status,
    String? message,
    UpdateGoalRequestModel? data,
  }) {

    return UpdateGoalState(
      status:
      status ?? this.status,

      message:
      message ?? this.message,

      data:
      data ?? this.data,
    );
  }
}