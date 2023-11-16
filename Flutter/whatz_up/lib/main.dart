import "package:whatz_up/app.dart";
import "package:whatz_up/utils/globals.dart";

void main() async {
  // Waits for flutter engine to be ready
  WidgetsFlutterBinding.ensureInitialized();
  // Starts the app
  runApp(const MyApp());
}
