import 'package:flutter/material.dart' hide Text, TextField;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/text.dart' show Text, TextField;
import '../../themes/color_theme.dart';
import '../../themes/text_theme.dart';

import '../main_screen.dart';

const double duration = 120000;

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  FocusNode focusNode = FocusNode();
  String name = '';
  int page = 0;
  bool visiblePrev = false;
  Map<String, double> topContainer = {
    'pad_t': 50,
    'pad_m': 23.83,
    'title+pad_b': 90,
  };

  Future<void> setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }

  void toNext() {
    if (page == 0) {
      topContainer['pad_t'] = 16.91;
      topContainer['pad_m'] = 0;
      topContainer['title+pad_b'] = 16.91;
    } else if (page == 5) {
      if (name.isNotEmpty) {
        focusNode.dispose();
        setName(name);
        Get.offAll(() => const MainScreen());
      } else {
        Get.snackbar(
          'warning',
          'type your name or nickname',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(milliseconds: 1500),
        );
      }
      return;
    }

    page += 1;
    setState(() {});
  }

  void toPrev() {
    if (page == 1) {
      topContainer['pad_t'] = 50;
      topContainer['pad_m'] = 23.83;
      topContainer['title+pad_b'] = 90;
    } else if (page == 0) {
      return;
    }

    page -= 1;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthRate = MediaQuery.of(context).size.width / 430;
    double heightRate = MediaQuery.of(context).size.height / 932;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          setState(() {
            focusNode.unfocus();
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 34 * widthRate),
          child: Column(
            children: [
              SizedBox(
                height: 73 * heightRate,
              ),
              AnimatedContainer(
                duration: Duration(microseconds: duration.toInt()),
                decoration: BoxDecoration(
                  color: MainColors.tutorialColor,
                  borderRadius: BorderRadius.circular(25 * heightRate),
                ),
                padding: EdgeInsets.only(
                  top: topContainer['pad_t']! * heightRate,
                  right: (25 * heightRate < 6 * widthRate)
                      ? 19 * widthRate
                      : 25 * heightRate - 6 * widthRate,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/logo.svg',
                          height: 24.17 * heightRate,
                        ),
                      ],
                    ),
                    AnimatedContainer(
                      duration: Duration(microseconds: duration.toInt()),
                      height: topContainer['pad_m']! * heightRate,
                    ),
                    Column(
                      children: [
                        AnimatedContainer(
                          duration: Duration(
                            microseconds: duration.toInt(),
                          ),
                          height: topContainer['title+pad_b']! * heightRate,
                          child: AnimatedOpacity(
                            duration: Duration(
                              microseconds: (duration * 51.83 / 96.91).toInt(),
                            ),
                            opacity: (page == 0) ? 1 : 0,
                            child: const Text(
                              '체크메이트에 오신 것을\n환영합니다!',
                              textAlign: TextAlign.right,
                              style: MainTextTheme.tutorialTitle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Page0Center(page == 0),
                  Page1Center(page == 1),
                  Page2Center(page == 2),
                  Page3Center(page == 3),
                  Page4Center(page == 4),
                  Page5Center(
                    page == 5,
                    focusNode: focusNode,
                    onChanged: (p0) {
                      setState(() {
                        name = p0;
                      });
                    },
                  ),
                ],
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              DotsIndicator(
                dotsCount: 6,
                position: page,
                decorator: DotsDecorator(
                  animation: true,
                  duration: Duration(microseconds: duration.toInt()),
                  color: MainColors.indicatorColor,
                  activeColor: MainColors.indicatorColor,
                  size: Size.square(10 * widthRate),
                  activeSize: Size(30 * widthRate, 10 * widthRate),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50 * widthRate),
                  ),
                ),
              ),
              SizedBox(
                height: 52 * heightRate,
              ),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          toPrev();
                        },
                        child: AnimatedOpacity(
                          duration: Duration(
                            microseconds: duration.toInt(),
                          ),
                          opacity: (page == 0) ? 0 : 1,
                          child: Container(
                            width: 140 * widthRate,
                            padding: EdgeInsets.symmetric(
                              vertical: 14 * heightRate,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                50 * widthRate,
                              ),
                              color: MainColors.buttonPrevColor,
                            ),
                            child: const Center(
                              child: Text(
                                '이전',
                                style: MainTextTheme.button,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 166 * widthRate,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: Duration(microseconds: duration.toInt()),
                        width: (page > 0) ? 166 * widthRate : 0,
                      ),
                      GestureDetector(
                        onTap: () {
                          toNext();
                        },
                        child: AnimatedContainer(
                          duration: Duration(microseconds: duration.toInt()),
                          width: (page > 0) ? 140 * widthRate : 250 * widthRate,
                          padding:
                              EdgeInsets.symmetric(vertical: 14 * heightRate),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50 * widthRate),
                            color: MainColors.highlightColor,
                          ),
                          child: Center(
                            child: Stack(
                              children: [
                                AnimatedOpacity(
                                  duration: Duration(
                                    microseconds: duration.toInt(),
                                  ),
                                  opacity: (page < 4) ? 1 : 0,
                                  child: const Text(
                                    '계속',
                                    style: MainTextTheme.button,
                                  ),
                                ),
                                AnimatedOpacity(
                                  duration: Duration(
                                    microseconds: duration.toInt(),
                                  ),
                                  opacity: (page >= 4) ? 1 : 0,
                                  child: const Text(
                                    '시작',
                                    style: MainTextTheme.button,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 67 * heightRate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Page0Center extends StatelessWidget {
  final bool visible;
  const Page0Center(
    this.visible, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // double widthRate = MediaQuery.of(context).size.width / 430;
    // double heightRate = MediaQuery.of(context).size.height / 932;
    return AnimatedOpacity(
      opacity: (visible) ? 1 : 0,
      duration: Duration(microseconds: duration.toInt()),
      child: Center(
        child: Text.rich(
          TextSpan(
            children: <TextSpan>[
              const TextSpan(
                text: '생산성',
                style: MainTextTheme.tutorialSlogan,
              ),
              TextSpan(
                text: ',\n간편하게 ',
                style: MainTextTheme.tutorialSlogan.copyWith(
                  color: Colors.black,
                ),
              ),
              const TextSpan(
                text: '완성.',
                style: MainTextTheme.tutorialSlogan,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Page1Center extends StatelessWidget {
  final bool visible;
  const Page1Center(
    this.visible, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // double widthRate = MediaQuery.of(context).size.width / 430;
    double heightRate = MediaQuery.of(context).size.height / 932;
    return AnimatedOpacity(
      opacity: (visible) ? 1 : 0,
      duration: Duration(microseconds: duration.toInt()),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset('assets/icons/tuto_page1.svg'),
            SizedBox(
              height: 15 * heightRate,
            ),
            const Text(
              '할 일이 생겼을 땐\n간편히 추가하고,',
              style: MainTextTheme.tutorialText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Page2Center extends StatelessWidget {
  final bool visible;
  const Page2Center(
    this.visible, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double widthRate = MediaQuery.of(context).size.width / 430;
    double heightRate = MediaQuery.of(context).size.height / 932;
    return AnimatedOpacity(
      opacity: (visible) ? 1 : 0,
      duration: Duration(microseconds: duration.toInt()),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 252 * widthRate,
              height: 256 * heightRate,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25 * heightRate),
                color: MainColors.todoBackgroundColor,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 21 * heightRate,
                horizontal: 16 * widthRate,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'To-Do List',
                    style: MainTextTheme.todoList.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: 19 * heightRate,
                  ),
                  Container(
                    height: 36.42384 * heightRate,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.28 * heightRate),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.74 * widthRate,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 14.6 * heightRate,
                          height: 14.6 * heightRate,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.73 * heightRate),
                            borderRadius: BorderRadius.circular(
                              2.19 * heightRate,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 9.47 * widthRate,
                        ),
                        Text(
                          'data',
                          style: MainTextTheme.todoListItem.copyWith(
                            fontSize: 14.57,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.58 * heightRate,
                  ),
                  Container(
                    height: 36.42384 * heightRate,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.28 * heightRate),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.74 * widthRate,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 14.6 * heightRate,
                          height: 14.6 * heightRate,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.73 * heightRate),
                            borderRadius: BorderRadius.circular(
                              2.19 * heightRate,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 9.47 * widthRate,
                        ),
                        Text(
                          'data',
                          style: MainTextTheme.todoListItem.copyWith(
                            fontSize: 14.57,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.58 * heightRate,
                  ),
                  Container(
                    height: 36.42384 * heightRate,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.28 * heightRate),
                      color: MainColors.todoSelectedColor,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.74 * widthRate,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 14.6 * heightRate,
                          height: 14.6 * heightRate,
                          decoration: BoxDecoration(
                            color: MainColors.todoSelectedCheckBoxColor,
                            borderRadius: BorderRadius.circular(
                              2.19 * heightRate,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 9.47 * widthRate,
                        ),
                        Text(
                          'data',
                          style: MainTextTheme.todoListItemSelected.copyWith(
                            fontSize: 14.57,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30 * heightRate,
            ),
            const Text(
              '간단히 할 일 완료를\n표시하세요.',
              style: MainTextTheme.tutorialText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Page3Center extends StatelessWidget {
  final bool visible;
  const Page3Center(
    this.visible, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // double widthRate = MediaQuery.of(context).size.width / 430;
    double heightRate = MediaQuery.of(context).size.height / 932;
    return AnimatedOpacity(
      opacity: (visible) ? 1 : 0,
      duration: Duration(microseconds: duration.toInt()),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset('assets/icons/tuto_page3.svg'),
            SizedBox(
              height: 15 * heightRate,
            ),
            const Text(
              '타이머를 이용하여\n생산성을 향상시키거나',
              style: MainTextTheme.tutorialText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Page4Center extends StatelessWidget {
  final bool visible;
  const Page4Center(
    this.visible, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // double widthRate = MediaQuery.of(context).size.width / 430;
    double heightRate = MediaQuery.of(context).size.height / 932;
    return AnimatedOpacity(
      opacity: (visible) ? 1 : 0,
      duration: Duration(microseconds: duration.toInt()),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset('assets/icons/tuto_page4.svg'),
            SizedBox(
              height: 15 * heightRate,
            ),
            const Text(
              'Pomodoro를 이용해\n효율적으로 작업해보세요.',
              style: MainTextTheme.tutorialText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Page5Center extends StatelessWidget {
  final bool visible;
  final FocusNode focusNode;
  final Function(String) onChanged;
  const Page5Center(
    this.visible, {
    super.key,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    double widthRate = MediaQuery.of(context).size.width / 430;
    double heightRate = MediaQuery.of(context).size.height / 932;
    return AnimatedOpacity(
      opacity: (visible) ? 1 : 0,
      duration: Duration(microseconds: duration.toInt()),
      child: Center(
        child: Column(
          children: [
            const Text(
              '당신의 이름을 알려주세요',
              style: MainTextTheme.tutorialText,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 23 * heightRate,
            ),
            Container(
              width: 170 * widthRate,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13 * heightRate),
                color: MainColors.textfieldNameColor,
              ),
              child: TextField(
                onChanged: onChanged,
                focusNode: focusNode,
                textAlign: TextAlign.center,
                style: MainTextTheme.tutorialInput,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(13 * heightRate),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 19 * heightRate,
            ),
            const Text(
              '이름을 알려주기 싫다면,\n별명도 좋아요',
              style: MainTextTheme.tutorialTip,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 105 * heightRate,
            ),
          ],
        ),
      ),
    );
  }
}
