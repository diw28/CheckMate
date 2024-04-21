import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/main_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/tutorial/tutorial_screen.dart';

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
  bool? newUser;

  Future<void> checkNewUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('name') == null) {
      newUser = true;
    } else {
      newUser = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkNewUser();
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
      home: (newUser == null)
          ? const SplashScreen()
          : (newUser!)
              ? const TutorialScreen()
              : const MainScreen(),
    );
  }
}
