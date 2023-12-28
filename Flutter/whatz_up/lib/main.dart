import "package:whatz_up/app.dart";
import "package:whatz_up/utils/globals.dart";

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Waits for Flutter engine to be ready
  WidgetsFlutterBinding.ensureInitialized();

  // Init localization
  await Locales.init(['en', 'pt', 'es', 'fr', 'ru', 'ja', 'de', 'it', 'zh']);

  // Init Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Init Hive
  await Hive.initFlutter();
  settingsBox = await Hive.openBox('settings');
  profileBox = await Hive.openBox('profile');

  // Init notifications
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  NotificationService.initialize(flutterLocalNotificationsPlugin);

  // Starts the app
  runApp(const App());
}
