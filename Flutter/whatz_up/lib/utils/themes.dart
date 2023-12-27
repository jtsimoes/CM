import "package:flutter/material.dart";

final ThemeData lightTheme = theme(Brightness.light);

final ThemeData darkTheme = theme(Brightness.dark);

ThemeData theme(Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF128C7E),
      background: brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF051B23),
      brightness: brightness,
    ),
  );
}
