import 'package:flutter/material.dart';
import 'package:local_notications_lesson/notification_service.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Local Notifications Demo'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: NotificationService().showSimpleNotification,
                child: const Text('Show Simple Notification'),
              ),
              ElevatedButton(
                onPressed: NotificationService().scheduleNotification,
                child: const Text('Show Scheduled Notification'),
              ),
              ElevatedButton(
                onPressed: NotificationService().recurringNotification,
                child: const Text('Show Recurring Notification'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: NotificationService().cancellAllNotifications,
                child: const Text(
                  'Cancell all notifications',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
