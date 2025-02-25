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
      bodyMedium: TextStyle(color: Colors.black87),
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

/// **Dark Theme**
ThemeData getDarkTheme() {
  return ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF1976D2),
      secondary: Color(0xFF001F3F),
      surface: Colors.black87, // Dark mode background
    ),

    /// **Dark Scaffold Background**
    scaffoldBackgroundColor: Colors.black87,

    /// **Dark AppBar Theme**
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1976D2),
      elevation: 4,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    /// **Dark Button Styling**
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1976D2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor: Colors.white,
      ),
    ),

    /// **Text Theme for Dark Mode**
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Montserrat Regular',
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),

    /// **Dark Divider**
    dividerColor: Colors.grey.shade700,
  );
}
