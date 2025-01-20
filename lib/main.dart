import 'package:flutter/material.dart';
import 'package:local_notications_lesson/app.dart';
import 'notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initializePlatformNotifications();
  runApp(const App());
}
