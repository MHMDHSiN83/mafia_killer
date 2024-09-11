import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: const Color.fromRGBO(17, 7, 7, 1),
    //primary: const Color.fromARGB(255, 40, 40, 40),
    primary: const Color(0xFF382E2E),
    secondary: Colors.grey.shade800,
    //secondary: Color(0xFF707070),
    tertiary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade200,
  ),
);
