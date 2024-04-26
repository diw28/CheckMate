import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../functions/notification.dart';
import 'home_screen.dart';
import 'tutorial_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? newUser;
  bool splashEnd = false;

  Future<void> checkNewUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('name') == null) {
      newUser = true;
    } else {
      newUser = false;
    }
    if (splashEnd) {
      if (newUser!) {
        Get.offAll(() => const TutorialScreen());
      } else {
        Get.offAll(() => const HomeScreen());
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    LocalNotification.init();
    checkNewUser();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
