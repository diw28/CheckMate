import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../functions/notification.dart';
import 'home_screen.dart';
import 'tutorial_screen.dart';

const _duration = 500;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int page = 0;
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
      await Future.delayed(const Duration(milliseconds: _duration));
      if (newUser!) {
        Get.offAll(
          () => const TutorialScreen(),
          transition: Transition.fadeIn,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 800),
        );
      } else {
        Get.offAll(
          () => const HomeScreen(),
          transition: Transition.fadeIn,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 800),
        );
      }
    }
    setState(() {});
  }

  Future<void> startAnimation() async {
    await Future.delayed(
      const Duration(milliseconds: _duration),
      () => setState(() {
        page = 1;
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    LocalNotification.init();
    checkNewUser();
  }

  @override
  Widget build(BuildContext context) {
    if (page == 0) {
      startAnimation();
      precacheImage(
        const AssetImage('assets/background/home_screen.png'),
        context,
      );
    }
    double widthRatio = MediaQuery.of(context).size.width / 430;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF190039),
            Color(0xFF7446E2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedScale(
                    duration: const Duration(milliseconds: _duration),
                    scale: page == 2 ? 136 / 44.88 : 1,
                    child: SvgPicture.asset(
                      'assets/icons/splash/check.svg',
                      width: 44.88 * widthRatio,
                    ),
                    onEnd: () async {
                      splashEnd = true;
                      if (newUser != null) {
                        await Future.delayed(
                          const Duration(milliseconds: _duration),
                        );
                        if (newUser!) {
                          Get.offAll(
                            () => const TutorialScreen(),
                            transition: Transition.fadeIn,
                            curve: Curves.linear,
                            duration: const Duration(milliseconds: 800),
                          );
                        } else {
                          Get.offAll(
                            () => const HomeScreen(),
                            transition: Transition.fadeIn,
                            curve: Curves.linear,
                            duration: const Duration(milliseconds: 800),
                          );
                        }
                      }
                      setState(() {});
                    },
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: _duration),
                    width: page == 0 ? 215.75 * widthRatio : 0,
                    height: 1,
                    onEnd: () {
                      setState(() {
                        page = 2;
                      });
                    },
                  ),
                ],
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: _duration),
                opacity: page == 0 ? 1 : 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 52.12 * widthRatio,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 2.98 * widthRatio,
                        bottom: 3.23 * widthRatio,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/splash/text.svg',
                        width: 208.51 * widthRatio,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
