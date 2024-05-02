import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/splash_screen.dart';
import 'themes/color_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: MainColors.mainColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
