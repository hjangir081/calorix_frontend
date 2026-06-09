import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../config/di/injector.dart';
import '../../../data/core/data_state.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/token_storage.dart';
import 'get_notification_state.dart';

final notificationProvider =
StateNotifierProvider<
    NotificationNotifier,
    NotificationState>(
      (ref) =>
      NotificationNotifier(),
);

class NotificationNotifier
    extends StateNotifier<
        NotificationState> {

  NotificationNotifier()
      : super(
    const NotificationState(),
  );

  final _repo =
  getIt<ApiRepository>();

  final _tokenStorage =
  getIt<TokenStorage>();

  Future<void>
  getNotifications({
    int limit = 20,
    int? cursor,
  }) async {

    try {

      state = state.copyWith(
        status:
        NotificationStatus.loading,
      );

      final token =
      await _tokenStorage
          .getAccessToken();

      if (token == null ||
          token.isEmpty) {

        state = state.copyWith(
          status:
          NotificationStatus.error,

          errorMessage:
          'User not authenticated',
        );

        return;
      }

      final response =
      await _repo.getNotification(
        token:
        'Bearer $token',
        limit: limit.toString(),
        cursor: 2.toString(),
      );

      if (response
      is DataSuccess) {

        state = state.copyWith(
          status:
          NotificationStatus.success,

          data:
          response.data?.result,

          errorMessage:
          null,
        );

      } else if (response
      is DataFailed) {

        state = state.copyWith(
          status:
          NotificationStatus.error,

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
        NotificationStatus.error,

        errorMessage:
        e.toString(),
      );
    }
  }

  /// LOCAL READ UPDATE

  void markAsRead(
      int notificationId,
      ) {

    final items =
        state.data?.items ?? [];

    final updatedItems =
    items.map(
          (e) {

        if (e.id ==
            notificationId) {

          return e.copyWith(
            readAt:
            DateTime.now()
                .toIso8601String(),
          );
        }

        return e;
      },
    ).toList();

    state = state.copyWith(
      data:
      state.data?.copyWith(
        items:
        updatedItems,

        unreadCount:
        updatedItems
            .where(
              (e) =>
          e.readAt ==
              null,
        )
            .length,
      ),
    );
  }

  /// RESET

  void reset() {

    state =
    const NotificationState();
  }
}