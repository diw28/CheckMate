import 'package:flutter/material.dart' hide Text, TextField;

import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/text.dart' show Text;
import '../themes/color_theme.dart';
import '../themes/text_theme.dart';
import 'add_todo_screen.dart';
import 'timer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<HomeScreen> {
  String name = '';
  int temperature = 2;
  String weather = 'snowy';

  Future<void> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? '';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    double widthRate = MediaQuery.of(context).size.width / 430;
    double heightRate = MediaQuery.of(context).size.height / 932;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background/home_screen.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.only(
            top: 51 * heightRate,
            left: 34 * widthRate,
            right: 34 * widthRate,
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: MainColors.homeScreenColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20 * heightRate),
                ),
                padding: EdgeInsets.only(
                  top: 13 * heightRate,
                  right: 26 * widthRate,
                  bottom: 12.83 * heightRate,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/logo.svg',
                      height: 24.17 * heightRate,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 48 * heightRate,
              ),
              Container(
                decoration: BoxDecoration(
                  color: MainColors.homeScreenColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20 * heightRate),
                ),
                padding: EdgeInsets.only(
                  top: 25 * heightRate,
                  bottom: 34 * heightRate,
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (name.length > 10)
                            ? '${name.substring(0, 10)}... 님,\n오늘도 체크메이트와 함께해요!'
                            : '$name 님,\n오늘도 체크메이트와 함께해요!',
                        style: MainTextTheme.homeScreenTitle,
                      ),
                      SizedBox(
                        height: 20 * heightRate,
                      ),
                      IntrinsicWidth(
                        child: Row(
                          children: [
                            homeScreenButton(
                              iconName: 'checkmate_add',
                              iconSize: 17,
                              text: '할 일 추가',
                              onTap: () async {
                                await Get.to(
                                  () => const AddTodoScreen(),
                                  transition: Transition.rightToLeft,
                                );
                                setState(() {});
                              },
                            ),
                            SizedBox(
                              width: 5 * widthRate,
                            ),
                            homeScreenButton(
                              iconName: 'checkmate_foodicon',
                              iconSize: 18,
                              text: '오늘의 급식',
                              onTap: () {
                                Get.to(
                                  () => const AddTodoScreen(),
                                  transition: Transition.rightToLeft,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 7 * heightRate,
                      ),
                      IntrinsicWidth(
                        child: Row(
                          children: [
                            homeScreenButton(
                              iconName: 'checkmate_pomodoro',
                              iconSize: 20,
                              text: 'Pomodoro',
                              onTap: () {
                                Get.to(
                                  () => const AddTodoScreen(),
                                  transition: Transition.rightToLeft,
                                );
                              },
                            ),
                            SizedBox(
                              width: 5 * widthRate,
                            ),
                            homeScreenButton(
                              iconName: 'checkmate_timer',
                              iconSize: 24,
                              text: '타이머',
                              onTap: () {
                                Get.to(
                                  () => const TimerScreen(),
                                  transition: Transition.rightToLeft,
                                );
                              },
                            ),
                            SizedBox(
                              width: 5 * widthRate,
                            ),
                            homeScreenButton(
                              iconName: 'weather/$weather',
                              iconSize: 25,
                              text: '$temperature℃',
                              onTap: () {
                                Get.to(
                                  () => const AddTodoScreen(),
                                  transition: Transition.rightToLeft,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 48 * heightRate,
              ),
              Container(
                decoration: BoxDecoration(
                  color: MainColors.todoBackgroundColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20 * heightRate),
                ),
                padding: EdgeInsets.only(
                  top: 25 * heightRate,
                  left: 27 * widthRate,
                  right: 29.9 * widthRate,
                  bottom: 34 * heightRate,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'To-Do List',
                          style: MainTextTheme.todoList,
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        GestureDetector(
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 22.3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25 * heightRate,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10 * heightRate,
                            ),
                          ),
                          child: const Row(
                            children: [],
                          ),
                        ),
                      ],
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

class homeScreenButton extends StatelessWidget {
  final String iconName;
  final double iconSize;
  final String text;
  final Function() onTap;
  const homeScreenButton({
    super.key,
    required this.iconName,
    required this.iconSize,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double widthRate = MediaQuery.of(context).size.width / 430;
    double heightRate = MediaQuery.of(context).size.height / 932;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 22 * heightRate + 21,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13 * heightRate),
          color: Colors.white,
        ),
        padding: EdgeInsets.only(
          left: 8 * widthRate,
          right: 10 * widthRate,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/$iconName.svg',
              height: iconSize,
              colorFilter: const ColorFilter.mode(
                MainColors.homeIconColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(
              width: 5 * widthRate,
            ),
            Text(
              text,
              style: MainTextTheme.homeScreenButton,
            ),
          ],
        ),
      ),
    );
  }
}
