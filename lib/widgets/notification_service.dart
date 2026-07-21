import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import '../roles/player/profile_details/complete_profile_page.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static const int profileNotificationId = 1001;

  static Future<void> init(GlobalKey<NavigatorState> key) async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.id == profileNotificationId) {
          key.currentState?.push(
            MaterialPageRoute(builder: (context) => const CompleteProfilePage()),
          );
        }
      },
    );

    // Request permissions for Android 13+
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> showCompleteProfileNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'profile_completion_channel',
      'Profile Completion',
      channelDescription: 'Reminders to complete user profile',
      importance: Importance.max,
      priority: Priority.high,
      // Auto-expire after 4 hours (14,400,000 milliseconds)
      timeoutAfter: 14400000,
    );
    
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await _notificationsPlugin.show(
      profileNotificationId,
      'Welcome to Statixa!',
      'Tap here to complete your profile (photo, ID, and details).',
      platformChannelSpecifics,
    );
  }

  static Future<void> clearProfileNotifications() async {
    await _notificationsPlugin.cancel(profileNotificationId);
  }
}
