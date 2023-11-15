import "package:flutter/material.dart";

final ThemeData lightTheme = theme(Brightness.light);

final ThemeData darkTheme = theme(Brightness.dark);

ThemeData theme(Brightness brightness) {
  return ThemeData.from(
    // Uncomment this line if you prefer to use premade material design widgets
    useMaterial3: true,
    textTheme: allBold,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0x00128C7E),
      background: brightness == Brightness.light
          // White background for light theme and background matching splash color for dark theme
          ? Colors.white
          : const Color(0xFF051B23),
      brightness: brightness,
    ),
  ).copyWith(
      //scrollbarTheme: alwaysShow,
      );
}

ScrollbarThemeData alwaysShow = ScrollbarThemeData(
  thumbVisibility: MaterialStateProperty.all<bool>(true),
  trackVisibility: MaterialStateProperty.all<bool>(true),
);

const TextTheme allBold = TextTheme(
  displayLarge: TextStyle(fontWeight: FontWeight.bold),
  displayMedium: TextStyle(fontWeight: FontWeight.bold),
  displaySmall: TextStyle(fontWeight: FontWeight.bold),
  headlineLarge: TextStyle(fontWeight: FontWeight.bold),
  headlineMedium: TextStyle(fontWeight: FontWeight.bold),
  headlineSmall: TextStyle(fontWeight: FontWeight.bold),
  titleLarge: TextStyle(fontWeight: FontWeight.bold),
  titleMedium: TextStyle(fontWeight: FontWeight.bold),
  titleSmall: TextStyle(fontWeight: FontWeight.bold),
  bodyLarge: TextStyle(fontWeight: FontWeight.bold),
  bodyMedium: TextStyle(fontWeight: FontWeight.bold),
  bodySmall: TextStyle(fontWeight: FontWeight.bold),
  labelLarge: TextStyle(fontWeight: FontWeight.bold),
  labelMedium: TextStyle(fontWeight: FontWeight.bold),
  labelSmall: TextStyle(fontWeight: FontWeight.bold),
);
