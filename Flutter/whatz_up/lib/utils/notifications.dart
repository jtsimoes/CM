import 'package:whatz_up/utils/globals.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class NotificationService {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('splash');
    var initializationsSettings =
        InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showNewMessageNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'whatzup_messages',
      'Messages',
      channelDescription: 'Notifies when a new message arrives',
      importance: Importance.max,
      priority: Priority.high,
      color: Color(0xFF128C7E),
      visibility: NotificationVisibility.public,
      category: AndroidNotificationCategory.message,
      actions: [
        AndroidNotificationAction(
          'reply',
          'Reply',
          allowGeneratedReplies: true,
          inputs: <AndroidNotificationActionInput>[
            AndroidNotificationActionInput(
              label: 'Reply',
            ),
          ],
        ),
        AndroidNotificationAction(
          'read',
          'Mark as read',
          showsUserInterface: true,
        ),
      ],
    );

    var details = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(id, title, body, details);
  }

  static Future showOngoingCallNotification(
      {var id = 69,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'whatzup_calls',
      'Calls',
      channelDescription: 'Notifies when a call is in progress',
      importance: Importance.max,
      priority: Priority.high,
      color: const Color(0xFF128C7E),
      visibility: NotificationVisibility.public,
      category: AndroidNotificationCategory.call,
      ongoing: true,
      usesChronometer: true,
      silent: true,
      actions: [
        AndroidNotificationAction(
          'end',
          'End call',
          showsUserInterface: true,
          titleColor: ThemeData().colorScheme.error,
        ),
        const AndroidNotificationAction(
          'speaker',
          'Turn speaker on',
        ),
      ],
    );

    var details = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(id, title, body, details);
  }
}
