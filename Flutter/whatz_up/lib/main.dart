import "package:whatz_up/app.dart";
import "package:whatz_up/utils/globals.dart";

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Waits for flutter engine to be ready
  WidgetsFlutterBinding.ensureInitialized();
  // Init Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Starts the app
  runApp(const MyApp());
}
