import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      fontFamily: 'NotoSans Regular',
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w200,
            fontFamily: 'NotoSans Regular'),
        backgroundColor: const Color(0xFF1976D2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      )),
      scaffoldBackgroundColor: Colors.grey[200]);
}
