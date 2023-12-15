import "package:whatz_up/app.dart";
import "package:whatz_up/utils/globals.dart";

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Waits for Flutter engine to be ready
  WidgetsFlutterBinding.ensureInitialized();

  // Init Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Init Hive
  boxSettings = await Hive.openBox('settings');

  // Starts the app
  runApp(App());
}
