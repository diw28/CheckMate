import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart' hide Text, TextField;

import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/text.dart' show Text;
import '../themes/text_theme.dart';
import '../themes/color_theme.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  late SharedPreferences prefs;
  Timer? timer;
  bool red = false;
  bool end = false;
  bool reset = false;
  bool useVibration = false;
  int hours = 00, minutes = 10, seconds = 00;
  TextEditingController controllerHour = TextEditingController(text: '00');
  TextEditingController controllerMinute = TextEditingController(text: '10');
  TextEditingController controllerSecond = TextEditingController(text: '00');
  CountDownController timerController = CountDownController();
  List<FocusNode> focusNodes = [
    for (var _ in [1, 2, 3]) FocusNode()
  ];

  Future<void> getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    useVibration = prefs.getBool('vibration') ?? false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  @override
  void dispose() {
    controllerHour.dispose();
    controllerMinute.dispose();
    controllerSecond.dispose();
    for (FocusNode focusNode in focusNodes) {
      focusNode.dispose();
    }
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          for (FocusNode focusNode in focusNodes) {
            focusNode.unfocus();
          }
        },
        child: Padding(
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
                      'assets/icons/checkmate_timer.svg',
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(
                      width: 9.33 * widthRatio,
                    ),
                    const Text(
                      '타이머',
                      style: MainTextTheme.pageTitle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 96 * heightRatio,
              ),
              CircularCountDownTimer(
                focusNodes: focusNodes,
                textFormat: "HH:mm:ss",
                controller: timerController,
                width: 300 * widthRatio,
                height: 300 * widthRatio,
                hours: hours,
                minutes: minutes,
                seconds: seconds,
                isReverse: true,
                autoStart: false,
                textStyle: MainTextTheme.timerText.copyWith(
                  fontSize: 45 * widthRatio,
                ),
                textAlign: TextAlign.center,
                strokeWidth: 3,
                fillColor: red ? Colors.red : MainColors.borderColor,
                ringColor: Colors.grey,
                onComplete: () {
                  if (reset) {
                    reset = false;
                    return;
                  }

                  int counter = 0;
                  timer = Timer.periodic(const Duration(milliseconds: 400),
                      (timer) {
                    if (counter < 20) {
                      if (useVibration && counter % 4 == 0) {
                        Vibration.vibrate(pattern: [600, 1000]);
                      }
                      setState(() {
                        end = true;
                        red = !red;
                        counter += 1;
                      });
                    } else {
                      setState(() {
                        end = false;
                        timerController.reset();
                        timer.cancel();
                      });
                    }
                  });
                },
              ),
              SizedBox(
                height: 57 * heightRatio,
              ),
              if (end)
                GestureDetector(
                  onTap: () {
                    timerController.reset();
                    red = false;
                    end = false;
                    timer?.cancel();
                    Vibration.cancel();
                    setState(() {});
                  },
                  child: Container(
                    width: 300 * widthRatio,
                    padding: EdgeInsets.symmetric(vertical: 14 * heightRatio),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50 * heightRatio),
                      color: MainColors.timerStop,
                    ),
                    child: const Center(
                      child: Text(
                        '초기화',
                        style: MainTextTheme.button,
                      ),
                    ),
                  ),
                )
              else if (!timerController.isStarted.value)
                GestureDetector(
                  onTap: () {
                    timerController.start();
                    setState(() {});
                  },
                  child: Container(
                    width: 300 * widthRatio,
                    padding: EdgeInsets.symmetric(vertical: 14 * heightRatio),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50 * heightRatio),
                      color: MainColors.highlightColor,
                    ),
                    child: const Center(
                      child: Text(
                        '타이머 시작',
                        style: MainTextTheme.button,
                      ),
                    ),
                  ),
                )
              else if (timerController.isPaused.value)
                SizedBox(
                  width: 300 * widthRatio,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            timerController.resume();
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 14 * heightRatio),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(50 * heightRatio),
                              color: MainColors.timerPaused,
                            ),
                            child: const Center(
                              child: Text(
                                '재시작',
                                style: MainTextTheme.button,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12 * widthRatio,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            reset = true;
                            timerController.reset();
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 14 * heightRatio),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(50 * heightRatio),
                              color: MainColors.timerPaused,
                            ),
                            child: const Center(
                              child: Text(
                                '초기화',
                                style: MainTextTheme.button,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                GestureDetector(
                  onTap: () {
                    timerController.pause();
                    setState(() {});
                  },
                  child: Container(
                    width: 300 * widthRatio,
                    padding: EdgeInsets.symmetric(vertical: 14 * heightRatio),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50 * heightRatio),
                      color: MainColors.timerStop,
                    ),
                    child: const Center(
                      child: Text(
                        '타이머 중지',
                        style: MainTextTheme.button,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 40 * heightRatio,
              ),
              SizedBox(
                width: 300 * widthRatio,
                child: const Divider(
                  height: 1,
                  thickness: 1,
                ),
              ),
              SizedBox(
                height: 48 * heightRatio,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6 * widthRatio),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        timerController.setTime(00, 03, 00);
                        setState(() {});
                      },
                      child: Container(
                        width: 100 * widthRatio,
                        height: 100 * widthRatio,
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(
                            side: BorderSide(
                              color: MainColors.borderColor,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '00 : 03 : 00',
                            style: MainTextTheme.timerText.copyWith(
                              fontSize: 14,
                              height: 17 / 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        timerController.setTime(00, 10, 00);
                        setState(() {});
                      },
                      child: Container(
                        width: 100 * widthRatio,
                        height: 100 * widthRatio,
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(
                            side: BorderSide(
                              color: MainColors.borderColor,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '00 : 10 : 00',
                            style: MainTextTheme.timerText.copyWith(
                              fontSize: 14,
                              height: 17 / 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        timerController.setTime(00, 60, 00);
                        setState(() {});
                      },
                      child: Container(
                        width: 100 * widthRatio,
                        height: 100 * widthRatio,
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(
                            side: BorderSide(
                              color: MainColors.borderColor,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '00 : 60 : 00',
                            style: MainTextTheme.timerText.copyWith(
                              fontSize: 14,
                              height: 17 / 14,
                            ),
                          ),
                        ),
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
