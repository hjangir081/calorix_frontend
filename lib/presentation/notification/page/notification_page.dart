import 'package:auto_route/annotations.dart';
import 'package:calorix_app/presentation/auth/widgets/app_gaps.dart';
import 'package:calorix_app/presentation/auth/widgets/app_padding.dart';
import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:calorix_app/utils/design/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/services/common_functions.dart';
import '../provider/get_notification_provider.dart';
import '../provider/get_notification_state.dart';

@RoutePage()
class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationState = ref.watch(notificationProvider);

    if (notificationState.status == NotificationStatus.initial) {
      Future.microtask(() {
        ref.read(notificationProvider.notifier).getNotifications();
      });
    }

    final notifications = notificationState.data?.items ?? [];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Notifications',
          style: AppQuicksandText.title(
            context,
          ).copyWith(fontWeight: FontWeight.bold, color: AppColors.black),
        ),
      ),

      body: AppPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGaps.h(context, 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppMediaQuery.height(context)*.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1E293B),
                    Color(0xFF0F172A),
                  ],
                ),
              ),

              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(.4),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.notifications_active_rounded,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  AppGaps.w16(context),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stay Updated',
                          style: AppQuicksandText.title(context).copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),

                        AppGaps.h4(context),

                        Text(
                          '${notificationState.data?.unreadCount ?? 0} unread notifications',
                          style: AppQuicksandText.body(
                            context,
                            color: AppColors.textPrimary
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            AppGaps.h(context, 26),

            Text(
              'Today',
              style: AppQuicksandText.title(
                color: AppColors.textPrimary,
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),

            AppGaps.h(context, 16),

            Expanded(
              child: notifications.isEmpty
                  ? Center(
                      child: Text(
                        'No notifications found',

                        style: AppQuicksandText.body(context),
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),

                      itemCount: notifications.length,

                      separatorBuilder: (_, __) => AppGaps.h(context, 14),

                      itemBuilder: (context, index) {
                        final item = notifications[index];

                        final isRead = item.readAt != null;

                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(notificationProvider.notifier)
                                .markAsRead(item.id ?? 0);
                          },

                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),

                            padding: const EdgeInsets.all(18),

                            decoration: BoxDecoration(
                              color: isRead
                                  ? AppColors.card
                                  : AppColors.primaryColor.withOpacity(.18),

                              borderRadius: BorderRadius.circular(24),

                              border: isRead
                                  ? null
                                  : Border.all(
                                      color: AppColors.primaryColor.withOpacity(
                                        .3,
                                      ),
                                    ),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.20),

                                  blurRadius: 12,

                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 54,
                                      width: 54,
                                      decoration: BoxDecoration(
                                        color: getNotificationColor(
                                          item.type,
                                        ).withOpacity(.15),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Icon(
                                        getNotificationIcon(item.type),
                                        color: getNotificationColor(item.type),
                                      ),
                                    ),

                                    if (!isRead)
                                      Positioned(
                                        top: 2,
                                        right: 2,
                                        child: Container(
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: isRead
                                                  ? AppColors.divider
                                                  : AppColors.primaryColor.withOpacity(.30),
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),

                                AppGaps.w16(context),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.title ?? '',
                                              style:
                                                  AppQuicksandText.title(
                                                    context,
                                                    color: AppColors.textPrimary
                                                  ).copyWith(
                                                    fontWeight: isRead
                                                        ? FontWeight.w600
                                                        : FontWeight.bold,
                                                  ),
                                            ),
                                          ),

                                          Text(
                                            AppDateFormatter.timeAgo(
                                              item.createdAt,
                                            ),
                                            style: AppQuicksandText.body(
                                              context,
                                            ).copyWith(color: AppColors.textSecondary),
                                          ),
                                        ],
                                      ),

                                      AppGaps.h8(context),

                                      Text(
                                        item.body ?? '',
                                        style: AppQuicksandText.body(
                                          context,
                                        ).copyWith(color: AppColors.textSecondary
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  IconData getNotificationIcon(String? type) {
    switch (type) {
      case 'meal':
        return Icons.restaurant;

      case 'streak':
        return Icons.local_fire_department;

      case 'protein':
        return Icons.bar_chart;

      default:
        return Icons.notifications;
    }
  }

  Color getNotificationColor(String? type) {
    switch (type) {
      case 'meal':
        return AppColors.primaryColor;

      case 'streak':
        return AppColors.secondaryColor;

      case 'protein':
        return Colors.orange;

      default:
        return Colors.blue;
    }
  }
}
