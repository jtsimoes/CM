import "package:whatz_up/utils/globals.dart";

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Listen to changes in the language preferences to refresh the UI
    return LocaleBuilder(
      builder: (locale) => ValueListenableBuilder(
        // Listen to changes in the dark theme preference to refresh the UI
        valueListenable: settingsBox.listenable(keys: ['darkMode']),
        builder: (context, box, child) {
          // Use .router for GoRouter
          return MaterialApp.router(
            color: const Color(0x00128C7E),
            title: 'WhatzUp',

            // Appearance options
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: box.get('darkMode', defaultValue: true)!
                ? ThemeMode.dark
                : ThemeMode.light,

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
