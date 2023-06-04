import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        cardColor: Colors.white,
        canvasColor: creamColor,
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        cardColor: Colors.black,
        canvasColor: darkCreamColor,
      );

  //Colors
  static Color creamColor = const Color(0xfff5f5f5);
  static Color darkCreamColor = Colors.grey.shade900;
}
