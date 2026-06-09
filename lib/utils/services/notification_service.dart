import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  static final FlutterLocalNotificationsPlugin
  _localNotifications =
  FlutterLocalNotificationsPlugin();

  /// LOCAL NOTIFICATION INITIALIZATION

  static Future<void>
  initializeLocalNotifications() async {

    const android =
    AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const ios =
    DarwinInitializationSettings();

    const settings =
    InitializationSettings(
      android: android,
      iOS: ios,
    );

    await _localNotifications.initialize(
      settings: settings,
    );

    /// FOREGROUND MESSAGE LISTENER

    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) {

        print(
          'FOREGROUND MESSAGE ===== '
              '${message.notification?.title}',
        );

        _showNotification(
          title:
          message.notification
              ?.title ??
              '',

          body:
          message.notification
              ?.body ??
              '',
        );
      },
    );

    /// OPEN APP FROM BACKGROUND

    FirebaseMessaging.onMessageOpenedApp.listen(
          (RemoteMessage message) {

        print(
          'NOTIFICATION CLICKED ===== '
              '${message.data}',
        );
      },
    );
  }

  /// ASK NOTIFICATION PERMISSION

  static Future<void>
  requestNotificationPermission() async {

    final settings =
    await FirebaseMessaging.instance
        .requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    print(
      'NOTIFICATION PERMISSION ===== '
          '${settings.authorizationStatus}',
    );

    if (settings.authorizationStatus ==
        AuthorizationStatus.authorized) {

      final fcmToken =
      await FirebaseMessaging.instance
          .getToken();

      print(
        'FCM TOKEN ===== '
            '$fcmToken',
      );
    }
  }

  /// SHOW LOCAL NOTIFICATION

  static Future<void> _showNotification({
    required String title,
    required String body,
  }) async {

    const androidDetails =
    AndroidNotificationDetails(
      'calorix_channel',
      'Calorix Notifications',

      channelDescription:
      'Calorix App Notifications',

      importance:
      Importance.max,

      priority:
      Priority.high,
    );

    const iosDetails =
    DarwinNotificationDetails();

    const details =
    NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      id: 0,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }

  /// REFRESH TOKEN LISTENER

  static void listenTokenRefresh() {

    FirebaseMessaging.instance
        .onTokenRefresh
        .listen(
          (newToken) {

        print(
          'FCM REFRESH TOKEN ===== '
              '$newToken',
        );

        /// SEND TO BACKEND
      },
    );
  }
}