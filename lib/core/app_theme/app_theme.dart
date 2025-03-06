import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1976D2),
      secondary: Color.fromARGB(255, 225, 232, 243),
    ),
    fontFamily: 'Montserrat Regular',
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1976D2),
      foregroundColor: Colors.white,
      elevation: 4,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF001F3F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    dividerColor: Colors.grey.shade300,
  );
}

ThemeData getDarkTheme() {
  final base = ThemeData.dark();

  return base.copyWith(
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(255, 0, 94, 255),
    scaffoldBackgroundColor: Colors.black87,
    cardColor: Colors.black26,
    dividerColor: Colors.grey.shade700,
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: const Color.fromARGB(255, 0, 94, 255),
      elevation: 4,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        fontFamily: 'Montserrat Bold',
        fontSize: 20,
        color: Colors.white,
      ),
      centerTitle: true,
    ),
    textTheme: base.textTheme.apply(
      fontFamily: 'Montserrat Regular',
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 94, 255),
        foregroundColor: Colors.white,
      ),
    ),
  );
}
