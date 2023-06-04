import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static void setLightStatusBar() =>
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark));

  static void setDarkStatusBar() =>
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light));
}
