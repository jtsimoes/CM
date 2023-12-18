import "package:whatz_up/utils/globals.dart";

final GlobalKey<GlobalAppState> globalAppKey = GlobalKey<GlobalAppState>();

class App extends StatefulWidget {
  App({Key? key}) : super(key: key ?? globalAppKey);

  @override
  GlobalAppState createState() => GlobalAppState();
}

class GlobalAppState extends State<App> {
  final ValueNotifier<bool> isDarkTheme =
      ValueNotifier<bool>(boxSettings.get('darkMode', defaultValue: true)!);

  // Toggle dark theme
  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    boxSettings.put('darkMode', isDarkTheme.value);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Listen to changes in the language preferences to refresh the UI
    return LocaleBuilder(
      builder: (locale) => ValueListenableBuilder(
        // Listen to changes in the dark theme preference to refresh the UI
        valueListenable: isDarkTheme,
        builder: (context, isDarkTheme, child) {
          // Use .router for GoRouter
          return MaterialApp.router(
            color: const Color(0x00128C7E),
            title: 'WhatzUp',

            // Appearance options
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,

            // Routing options
            routerConfig: router,

            // Translation options
            localizationsDelegates: Locales.delegates,
            supportedLocales: Locales.supportedLocales,
            locale: locale,

            // Debug options
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
