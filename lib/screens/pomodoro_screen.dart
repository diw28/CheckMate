import 'dart:async';

import 'package:flutter/material.dart' hide Text, TextField;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vibration/vibration.dart';
import 'package:get/get.dart';

import '../static.dart';
import '../widgets/text.dart';
import '../themes/color_theme.dart';
import '../themes/text_theme.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});
  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  late SharedPreferences prefs;
  late Timer timer;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  bool isRest = false;
  int totalPomodoros = 0;
  int goal = 1;
  bool useVibration = false;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      if (isRest) {
        // 쉬는 시간이 끝났을 때
        setState(() {
          totalPomodoros = totalPomodoros + 1;
          isRest = false;
          totalSeconds = twentyFiveMinutes;
          isRunning = false;
        });
      } else {
        // 작업 시간이 끝났을 때
        if (useVibration) {
          Vibration.vibrate(pattern: [
            for (int i = 0; i < 5; i++)
              for (int j = 0; j < 2; j++) 600 + j * 400
          ]);
        }
        setState(() {
          isRest = true;
          totalSeconds = fiveMinutes;
          isRunning = false;
        });
      }
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration
        .toString()
        .split(".")
        .first
        .substring(2, 7)
        .replaceFirst(':', ' : ');
  }

  Future<void> getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    goal = prefs.getInt('goal') ?? goal;
    useVibration = prefs.getBool('vibration') ?? false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: 51 * heightRatio,
          left: 34 * widthRatio,
          right: 34 * widthRatio,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: MainColors.mainColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.only(
                top: 13,
                bottom: 12.83,
                left: 15.33 * widthRatio,
                right: 26 * widthRatio,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const SizedBox(
                      width: 23,
                      height: 23,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 23,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  SvgPicture.asset(
                    'assets/icons/checkmate_pomodoro.svg',
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(
                    width: 4 * widthRatio,
                  ),
                  const Text(
                    'Pomodoro',
                    style: MainTextTheme.pageTitle,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 91,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: MainColors.borderColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.only(
                top: 42 * heightRatio,
                bottom: 30 * heightRatio,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    format(totalSeconds),
                    style: MainTextTheme.timerText.copyWith(
                      fontSize: 55,
                      height: 67 / 55,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 13 * heightRatio,
                      ),
                    ],
                  ),
                  Text(
                    isRest ? '5분 동안 휴식하세요!' : '할 일에 집중하세요!',
                    textAlign: TextAlign.center,
                    style: MainTextTheme.timerText.copyWith(
                      fontSize: 22.5,
                      height: 27 / 22.5,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 37 * heightRatio,
            ),
            GestureDetector(
              onTap: isRunning ? onPausePressed : onStartPressed,
              child: Container(
                width: 192 * widthRatio,
                height: 70 * heightRatio,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50 * heightRatio),
                  color: isRunning
                      ? MainColors.timerStop
                      : MainColors.highlightColor,
                ),
                alignment: Alignment.center,
                child: Icon(
                  isRunning ? Icons.pause : Icons.play_arrow,
                  size: 37,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 80 * heightRatio,
            ),
            Container(
              width: 300 * widthRatio,
              height: 1,
              color: Colors.black,
            ),
            SizedBox(height: 34 * heightRatio),
            Container(
              width: 330 * widthRatio,
              decoration: BoxDecoration(
                color: const Color(0xFFE5D6FF),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.only(
                top: 16 * heightRatio,
                bottom: 22 * heightRatio,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$totalPomodoros',
                          style: MainTextTheme.pomodoroCount,
                        ),
                        Text(
                          'Pomodoros',
                          style: MainTextTheme.pomodoroCount.copyWith(
                            fontSize: 20,
                            height: 24 / 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: 3,
                    height: 75,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '$totalPomodoros',
                                style: MainTextTheme.pomodoroCount,
                              ),
                              TextSpan(
                                text: '/$goal',
                                style: MainTextTheme.pomodoroCount.copyWith(
                                  fontSize: 20,
                                  height: 24 / 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Goals',
                          style: MainTextTheme.pomodoroCount.copyWith(
                            fontSize: 20,
                            height: 24 / 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
