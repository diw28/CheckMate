import 'package:flutter/material.dart' hide Text, TextField;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../static.dart';
import '../functions/notification.dart';
import '../functions/todo.dart';
import '../themes/color_theme.dart';
import '../themes/text_theme.dart';
import '../widgets/text.dart';
import '../widgets/toggle_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SharedPreferences prefs;
  final TextEditingController _controller = TextEditingController();
  FocusNode focusNodePeriod = FocusNode();
  FocusNode focusNodeGoal = FocusNode();
  FocusNode focusNodeName = FocusNode();
  bool notice = true;
  bool vibration = true;
  int? period;
  int goal = 1;
  String name = '';

  Future<void> getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    notice = prefs.getBool('notice') ?? true;
    vibration = prefs.getBool('vibration') ?? true;
    if (notice) period = prefs.getInt('period');
    goal = prefs.getInt('goal') ?? 1;
    name = prefs.getString('name')!;
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
      body: GestureDetector(
        onTap: () {
          focusNodeGoal.unfocus();
          focusNodeName.unfocus();
          focusNodePeriod.unfocus();
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
                      'assets/icons/checkmate_settings.svg',
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(
                      width: 6 * widthRatio,
                    ),
                    const Text(
                      '설정',
                      style: MainTextTheme.pageTitle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30 * heightRatio,
              ),
              GestureDetector(
                onTap: () async {
                  notice = !notice;
                  prefs.setBool('notice', notice);
                  if (notice) {
                    for (Todo todo in await Todo.getAll()) {
                      LocalNotification.set(todo);
                    }
                  } else {
                    LocalNotification.cancelAll();
                  }
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20 * heightRatio),
                    color: MainColors.settingBackground,
                  ),
                  padding: EdgeInsets.only(
                    top: 14 * heightRatio,
                    bottom: 13 * heightRatio,
                    left: 15 * widthRatio,
                    right: 15 * widthRatio,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '할 일 알림',
                            style: MainTextTheme.settingTitle.copyWith(
                              fontSize: 19 * widthRatio,
                            ),
                          ),
                          SizedBox(
                            height: 3 * heightRatio,
                          ),
                          Text(
                            '시간을 지정한 할 일을 알림으로 알려드려요',
                            style: MainTextTheme.settingtext.copyWith(
                              fontSize: 14 * widthRatio,
                            ),
                          ),
                        ],
                      ),
                      ToggleButton(notice),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15 * heightRatio,
              ),
              AnimatedOpacity(
                opacity: notice ? 1 : 0.5,
                duration: Duration(microseconds: duration.toInt()),
                curve: Curves.ease,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20 * heightRatio),
                    color: MainColors.settingBackground,
                  ),
                  padding: EdgeInsets.only(
                    top: 14 * heightRatio,
                    bottom: 13 * heightRatio,
                    left: 15 * widthRatio,
                    right: 11 * widthRatio,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '알림 시간',
                            style: MainTextTheme.settingTitle.copyWith(
                              fontSize: 19 * widthRatio,
                            ),
                          ),
                          SizedBox(
                            height: 3 * heightRatio,
                          ),
                          Text(
                            '할 일 알림 시간을 설정하세요',
                            style: MainTextTheme.settingtext.copyWith(
                              fontSize: 14 * widthRatio,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 120 * widthRatio,
                        height: 35 * heightRatio,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10 * heightRatio),
                          color: MainColors.textfieldNameColor,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 6 * widthRatio,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (p0) async {
                                  if ((int.tryParse(p0) ?? -1) >= 0) {
                                    period = int.parse(p0);
                                    await prefs.setInt('period', period!);
                                    LocalNotification.updatePeriod();
                                  }
                                },
                                enabled: notice,
                                controller: _controller,
                                focusNode: focusNodePeriod,
                                textAlign: TextAlign.end,
                                style: MainTextTheme.input,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: '${period ?? 0}',
                                  hintStyle: MainTextTheme.input.copyWith(
                                    color: TextColors.textfieldHint,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.circular(10 * heightRatio),
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              '분 전',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15 * heightRatio,
              ),
              GestureDetector(
                onTap: () {
                  vibration = !vibration;
                  prefs.setBool('vibration', vibration);
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20 * heightRatio),
                    color: MainColors.settingBackground,
                  ),
                  padding: EdgeInsets.only(
                    top: 14 * heightRatio,
                    bottom: 13 * heightRatio,
                    left: 15 * widthRatio,
                    right: 15 * widthRatio,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '진동 설정',
                            style: MainTextTheme.settingTitle.copyWith(
                              fontSize: 19 * widthRatio,
                            ),
                          ),
                          SizedBox(
                            height: 3 * heightRatio,
                          ),
                          Text(
                            '타이머가 종료되면 진동이 울려요',
                            style: MainTextTheme.settingtext.copyWith(
                              fontSize: 14 * widthRatio,
                            ),
                          ),
                        ],
                      ),
                      ToggleButton(vibration),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15 * heightRatio,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20 * heightRatio),
                  color: MainColors.settingBackground,
                ),
                padding: EdgeInsets.only(
                  top: 14 * heightRatio,
                  bottom: 13 * heightRatio,
                  left: 15 * widthRatio,
                  right: 11 * widthRatio,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pomodoro 목표',
                          style: MainTextTheme.settingTitle.copyWith(
                            fontSize: 19 * widthRatio,
                          ),
                        ),
                        SizedBox(
                          height: 3 * heightRatio,
                        ),
                        Text(
                          'Pomodoro 타이머에 표시돼요',
                          style: MainTextTheme.settingtext.copyWith(
                            fontSize: 14 * widthRatio,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 120 * widthRatio,
                      height: 35 * heightRatio,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10 * heightRatio),
                        color: MainColors.textfieldNameColor,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14 * widthRatio,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (p0) {
                                if ((int.tryParse(p0) ?? 0) > 0) {
                                  goal = int.parse(p0);
                                  prefs.setInt('goal', goal);
                                  setState(() {});
                                }
                              },
                              focusNode: focusNodeGoal,
                              textAlign: TextAlign.end,
                              style: MainTextTheme.input,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '$goal',
                                hintStyle: MainTextTheme.input.copyWith(
                                  color: TextColors.textfieldHint,
                                ),
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.circular(10 * heightRatio),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            '회',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15 * heightRatio,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20 * heightRatio),
                  color: MainColors.settingBackground,
                ),
                padding: EdgeInsets.only(
                  top: 14 * heightRatio,
                  bottom: 13 * heightRatio,
                  left: 15 * widthRatio,
                  right: 25 * widthRatio,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40 * widthRatio + 3 * heightRatio,
                      alignment: Alignment.center,
                      child: Text(
                        '이름 변경',
                        style: MainTextTheme.settingTitle.copyWith(
                          fontSize: 19 * widthRatio,
                        ),
                      ),
                    ),
                    Container(
                      width: 120 * widthRatio,
                      height: 35 * heightRatio,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10 * heightRatio),
                        color: MainColors.textfieldNameColor,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14 * widthRatio,
                      ),
                      child: TextField(
                        onChanged: (p0) {
                          if (p0.isEmpty) return;
                          name = p0;
                          prefs.setString('name', name);
                          setState(() {});
                        },
                        focusNode: focusNodeName,
                        textAlign: TextAlign.center,
                        style: MainTextTheme.input,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: name,
                          hintStyle: MainTextTheme.input.copyWith(
                            color: TextColors.textfieldHint,
                          ),
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.circular(10 * heightRatio),
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
