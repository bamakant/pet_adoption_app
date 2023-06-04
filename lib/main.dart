import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_adoption_app/config/route.dart';
import 'package:pet_adoption_app/utils/theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));

  runApp(const PetApp());
}

class PetApp extends StatelessWidget {
  const PetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Adoption App',
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      initialRoute: Routes.homeRoute,
      routes: Routes.getRoute(),
      debugShowCheckedModeBanner: false,
    );
  }
}
