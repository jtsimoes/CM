import "package:whatz_up/app.dart";
import "package:whatz_up/utils/globals.dart";

void main() async {
  // Waits for flutter engine to be ready
  WidgetsFlutterBinding.ensureInitialized();
  // Sets the app to fullscreen on mobile devices
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // Hides the # in the web version URL
  setPathUrlStrategy();
  // Starts the app
  runApp(const MyApp());
}
