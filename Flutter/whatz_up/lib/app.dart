import "package:whatz_up/utils/globals.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Use .router for GoRouter
    return MaterialApp.router(
      title: 'WhatzUp',

      // Appearence options
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,

      // Routing options
      routerConfig: router,

      // Translation options
      locale: const Locale("en", "US"),

      // Debug options
      debugShowCheckedModeBanner: false,
      //showSemanticsDebugger: true,
      //showPerformanceOverlay: true,
    );
  }
}
