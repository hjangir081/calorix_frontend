import '../../../domain/models/response/get_notification_response_model.dart';

enum NotificationStatus {
  initial,
  loading,
  success,
  error,
}

class NotificationState {

  final NotificationStatus status;

  final Result? data;

  final String? errorMessage;

  const NotificationState({
    this.status =
        NotificationStatus.initial,

    this.data,

    this.errorMessage,
  });

  NotificationState copyWith({
    NotificationStatus? status,
    Result? data,
    String? errorMessage,
  }) {

    return NotificationState(
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