import 'package:flutter/material.dart';

/// **Light Theme**
ThemeData getApplicationTheme() {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1976D2),
      secondary: Color.fromARGB(255, 225, 232, 243),
      surface: Color(0xFFF5F5F5), // Light background
    ),
    fontFamily: 'Montserrat Regular',

    /// **AppBar Theme**
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

    /// **Button Styling**
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF001F3F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor: Colors.white,
      ),
    ),

    /// **Text Theme for Light Mode**
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),

    /// **Scaffold Background**
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    dividerColor: Colors.grey.shade300,
  );
}

ThemeData getDarkTheme() {
  // Start with a base dark theme
  final base = ThemeData.dark();

  return base.copyWith(
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(255, 0, 94, 255),

    // Dark scaffold background
    scaffoldBackgroundColor: Colors.black87,

    // Card color in dark mode
    cardColor: Colors.black26,

    // Divider color for dark mode
    dividerColor: Colors.grey.shade700,

    // AppBar styling
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

    // Text styling in dark mode
    textTheme: base.textTheme.apply(
      fontFamily: 'Montserrat Regular',
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),

    // Elevated button styling in dark mode
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
