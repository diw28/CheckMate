import 'package:check_mate/functions/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static final notifications = FlutterLocalNotificationsPlugin();

  LocalNotification._();

  static Future<void> init() async {
    await notifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('notification_icon'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      ),
      onDidReceiveNotificationResponse: (payload) {},
    );
    PermissionStatus status = await Permission.notification.status;
    if (status.isPermanentlyDenied || status.isGranted) return;
    await Permission.notification.request();
  }

  static Future<void> set(Todo todo) async {
    var androidDetails = const AndroidNotificationDetails(
      'ID',
      'NAME',
      priority: Priority.high,
      importance: Importance.max,
    );
    var iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    String name = todo.name;
    TimeOfDay time = stringToTimeOfDay(todo.time);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int period = prefs.getInt('period') ?? 0;

    DateTime now = DateTime.now();
    DateTime dateTime = now
        .copyWith(
          hour: time.hour,
          minute: time.minute,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        )
        .subtract(Duration(minutes: period));
    if (dateTime.isBefore(now)) {
      dateTime = dateTime.add(const Duration(days: 1));
    }

    int notificationId = name.hashCode;

    tz.initializeTimeZones();
    try {
      await notifications.zonedSchedule(
        notificationId,
        'CheckMate',
        "'$name' 일정이 곧 완료됩니다",
        tz.TZDateTime.from(
          dateTime,
          tz.local,
        ),
        NotificationDetails(android: androidDetails, iOS: iosDetails),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<void> cancel(String name) async {
    try {
      int notificationId = name.hashCode;
      await notifications.cancel(notificationId);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> cancelAll() async {
    try {
      await notifications.cancelAll();
    } catch (e) {
      print(e);
    }
  }

  static Future<void> updatePeriod() async {
    cancelAll();
    for (Todo todo in await Todo.getAll()) {
      set(todo);
    }
  }
}
