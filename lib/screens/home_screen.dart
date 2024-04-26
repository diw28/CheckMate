import 'package:check_mate/functions/todo_list.dart';
import 'package:check_mate/screens/pomodoro_screen.dart';
import 'package:check_mate/screens/settings_screen.dart';
import 'package:flutter/material.dart' hide Text, TextField;

import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/text.dart' show Text;
import '../themes/color_theme.dart';
import '../themes/text_theme.dart';
import '../widgets/todo_list.dart';
import 'add_todo_screen.dart';
import 'timer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  int temperature = 2;
  String weather = 'snowy';
  List<Todo> todos = [];

  Future<void> getTodo() async {
    todos = await Todo.getAll();
    setState(() {});
  }

  Future<void> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? '';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getName();
    getTodo();
  }

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background/home_screen.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                  color: MainColors.homeScreenColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20 * heightRatio),
                ),
                padding: EdgeInsets.only(
                  top: 13 * heightRatio,
                  right: 26 * widthRatio,
                  bottom: 12.83 * heightRatio,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/logo.svg',
                      height: 24.17 * heightRatio,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 48 * heightRatio,
              ),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: MainColors.homeScreenColor.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20 * heightRatio),
                    ),
                    padding: EdgeInsets.only(
                      top: 30 * heightRatio,
                      bottom: 34 * heightRatio,
                      left: 25 * widthRatio,
                      right: 25 * widthRatio,
                    ),
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
                          height: 26 * heightRatio,
                        ),
                        Row(
                          children: [
                            HomeScreenButton(
                              iconName: 'checkmate_add',
                              iconSize: 17,
                              text: '할 일 추가',
                              onTap: () async {
                                await Get.to(
                                  () => const AddTodoScreen(),
                                  transition: Transition.rightToLeft,
                                );
                                getTodo();
                              },
                            ),
                            SizedBox(
                              width: 5 * widthRatio,
                            ),
                            HomeScreenButton(
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
                        SizedBox(
                          height: 7 * heightRatio,
                        ),
                        Row(
                          children: [
                            HomeScreenButton(
                              iconName: 'checkmate_pomodoro',
                              iconSize: 20,
                              text: 'Pomodoro',
                              onTap: () {
                                Get.to(
                                  () => const PomodoroScreen(),
                                  transition: Transition.rightToLeft,
                                );
                              },
                            ),
                            SizedBox(
                              width: 5 * widthRatio,
                            ),
                            HomeScreenButton(
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
                              width: 5 * widthRatio,
                            ),
                            HomeScreenButton(
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
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Get.to(
                        () => const SettingsScreen(),
                        transition: Transition.rightToLeft,
                      );
                      getName();
                    },
                    child: Container(
                      padding: EdgeInsets.all(12 * heightRatio),
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(
                        'assets/icons/checkmate_settings.svg',
                        colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.8),
                          BlendMode.srcIn,
                        ),
                        width: 20 * heightRatio,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48 * heightRatio,
              ),
              TodoListBox(todos),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreenButton extends StatelessWidget {
  final String iconName;
  final double iconSize;
  final String text;
  final Function() onTap;
  const HomeScreenButton({
    super.key,
    required this.iconName,
    required this.iconSize,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 43 * heightRatio,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13 * heightRatio),
          color: Colors.white,
        ),
        padding: EdgeInsets.only(
          left: 8 * widthRatio,
          right: 10 * widthRatio,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/$iconName.svg',
              height: iconSize * widthRatio,
              colorFilter: const ColorFilter.mode(
                MainColors.homeIconColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(
              width: 5 * widthRatio,
            ),
            Text(
              text,
              style: MainTextTheme.homeScreenButton.copyWith(
                fontSize: 17 * widthRatio,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
