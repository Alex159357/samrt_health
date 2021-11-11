import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:samrt_health/pages/runner/runner.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final onNotifications = BehaviorSubject<String?>();

  static void showNotificationMessage() async {
    flutterLocalNotificationsPlugin.show(
        0, "title", "body", await notificationDetails(), payload: "TEST NOTIFI");
  }

  static void showNotificationScheduled() async {
    flutterLocalNotificationsPlugin.zonedSchedule(
        0, "title", "body",
        _nextInstanceOfTenAM(),//tz.TZDateTime.from(DateTime.now().add(Duration(seconds: 10)), tz.local),
        await notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      payload: "PAYLOAD"
        );
  }

  static tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, 22,00);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static init({bool initScheduled = false}) async {
    await _configureLocalTimeZone();
    //Initialization Settings for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('coworker');

    //Initialization Settings for iOS
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    const InitializationSettings settings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(settings,
        onSelectNotification: (String? payLoad) =>
            onNotifications.add(payLoad));
  }

  static Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }


  static Future notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
            'channel_id', 'channel_name',
            channelDescription: 'your updated channel description',
            // channelAction: AndroidNotificationChannelAction.update,
            playSound: true,
            importance: Importance.max,
            priority: Priority.high,
            largeIcon: DrawableResourceAndroidBitmap('coworker'),
            sound: RawResourceAndroidNotificationSound('@raw/slow_spring_board')),
        iOS: IOSNotificationDetails(
            // sound: 'slow_spring_board.mp3',
            presentAlert: true,
            presentBadge: true,
            presentSound: true));
  }
}
// slow_spring_board
