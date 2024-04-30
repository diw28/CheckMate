import 'package:flutter/material.dart' hide Text;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../static.dart';
import '../widgets/text.dart' show Text;
import '../themes/color_theme.dart';
import '../themes/text_theme.dart';

import '../widgets/tutorial_page.dart';
import 'home_screen.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  FocusNode focusNode = FocusNode();
  String name = '';
  int page = 0;

  Future<void> setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }

  void toNext() {
    if (page == 5) {
      if (name.isNotEmpty) {
        focusNode.dispose();
        setName(name);
        Get.offAll(() => const HomeScreen());
      } else {
        Get.closeAllSnackbars();
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
    if (page == 0) return;

    page -= 1;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          setState(() {
            focusNode.unfocus();
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 34 * widthRatio),
          child: Column(
            children: [
              SizedBox(
                height: 73 * heightRatio,
              ),
              AnimatedContainer(
                duration: Duration(microseconds: duration.toInt()),
                decoration: BoxDecoration(
                  color: MainColors.tutorialColor,
                  borderRadius: BorderRadius.circular(
                    (page == 0) ? 25 * heightRatio : 20 * heightRatio,
                  ),
                ),
                padding: EdgeInsets.only(
                  top: (page == 0) ? 50 * heightRatio : 16.91 * heightRatio,
                  right: (25 * heightRatio < 6 * widthRatio)
                      ? 19 * widthRatio
                      : 25 * heightRatio - 6 * widthRatio,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/logo.svg',
                          height: 24.17 * heightRatio,
                        ),
                      ],
                    ),
                    AnimatedContainer(
                      duration: Duration(microseconds: duration.toInt()),
                      height: (page == 0) ? 23.83 * heightRatio : 0,
                    ),
                    Column(
                      children: [
                        AnimatedContainer(
                          duration: Duration(
                            microseconds: duration.toInt(),
                          ),
                          height: (page == 0) ? 90 * heightRatio : 16.91,
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
                  size: Size.square(10 * widthRatio),
                  activeSize: Size(30 * widthRatio, 10 * widthRatio),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50 * widthRatio),
                  ),
                ),
              ),
              SizedBox(
                height: 52 * heightRatio,
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
                            width: 140 * widthRatio,
                            padding: EdgeInsets.symmetric(
                              vertical: 14 * heightRatio,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                50 * heightRatio,
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
                        width: 166 * widthRatio,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: Duration(microseconds: duration.toInt()),
                        width: (page > 0) ? 166 * widthRatio : 0,
                      ),
                      GestureDetector(
                        onTap: () {
                          toNext();
                        },
                        child: AnimatedContainer(
                          duration: Duration(microseconds: duration.toInt()),
                          width:
                              (page > 0) ? 140 * widthRatio : 250 * widthRatio,
                          padding:
                              EdgeInsets.symmetric(vertical: 14 * heightRatio),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(50 * heightRatio),
                            color: MainColors.highlightColor,
                          ),
                          child: Center(
                            child: Stack(
                              children: [
                                AnimatedOpacity(
                                  duration: Duration(
                                    microseconds: duration.toInt(),
                                  ),
                                  opacity: (page < 5) ? 1 : 0,
                                  child: const Text(
                                    '계속',
                                    style: MainTextTheme.button,
                                  ),
                                ),
                                AnimatedOpacity(
                                  duration: Duration(
                                    microseconds: duration.toInt(),
                                  ),
                                  opacity: (page >= 5) ? 1 : 0,
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
                height: 67 * heightRatio,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
