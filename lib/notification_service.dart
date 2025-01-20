import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final _localNotifications = FlutterLocalNotificationsPlugin();

  // Android va iOS platformalari uchun Bildirishnomalarni ishga tushirish
  Future<void> initializePlatformNotifications() async {
    // Android da Bildirishnomalar uchun ruxsat so'rash
    _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // [timezone] plugin dagi mintaqa vaqtlari ma'lumotlar bazasini
    // yuklaydi [load qiladi]
    tz.initializeTimeZones();

    // Android sozlamasi [settings]
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS sozlamalasi
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    // Barcha platformarlar sozlamalari yigindisi
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // pluginni Barcha platformarlar uchun ishga tushirish
    await _localNotifications.initialize(initializationSettings);
  }

  // Bir martalik bildrishnoma [one-time]
  void showSimpleNotification() {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'simple_channel_id',
      'Simple Notifications',
      channelDescription: 'This is for simple notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    _localNotifications.show(
      0,
      'Simple Notification',
      'This is a simple notification!',
      notificationDetails,
    );
  }

  // Rejali bildirishnoma [scheduled]
  void scheduleNotification() async {
    // Android uchun bildirishnoma tafsilotlari
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'scheduled_channel_id',
      'Scheduled Notifications',
      channelDescription: 'This is for scheduled notifications',
      importance: Importance.max,
      priority: Priority.max,
    );

    // iOS uchun bildirishnoma tafsilotlari
    const iOSNotificationDetails = DarwinNotificationDetails();

    // Umumiy tavsif, barcha platformalar uchun tavsif
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSNotificationDetails,
    );

    await _localNotifications.zonedSchedule(
      1, // Id
      'Scheduled Notification', // Sarlavha [Title]
      'This notification is scheduled!', // Kichik sarlavha [Subtitle]
      tz.TZDateTime.now(tz.local)
          .add(const Duration(seconds: 5)), // Vaqti [Schedule Date]
      notificationDetails, // Bildirishnoma tavsifi
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation
              .wallClockTime, // Sana va vaqt talqini / Mahalliy vs UTC
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // Takroriy bildirishnoma [recurring]
  void recurringNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'recurring_channel_id',
      'Recurring Notifications',
      channelDescription: 'This is for recurring notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _localNotifications.periodicallyShow(
      2,
      'Recurring Notification',
      'This notification recurs every minute!',
      RepeatInterval.everyMinute,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  void cancellAllNotifications() async {
    await _localNotifications.cancel(1);
    await _localNotifications.cancel(2);
  }
}
