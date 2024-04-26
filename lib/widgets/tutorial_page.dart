import 'package:flutter/material.dart' hide Text, TextField;

import 'package:flutter_svg/flutter_svg.dart';

import '../static.dart';
import '../themes/color_theme.dart';
import '../themes/text_theme.dart';
import 'text.dart';

class Page0Center extends StatelessWidget {
  final bool visible;
  const Page0Center(
    this.visible, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // double widthRatio = MediaQuery.of(context).size.width / 430;
    // double heightRatio = MediaQuery.of(context).size.height / 932;
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
    // double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return AnimatedOpacity(
      opacity: (visible) ? 1 : 0,
      duration: Duration(microseconds: duration.toInt()),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/checkmate_add.svg',
              height: 110,
              colorFilter: const ColorFilter.mode(
                MainColors.tutorialColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(
              height: 15 * heightRatio,
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
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return AnimatedOpacity(
      opacity: (visible) ? 1 : 0,
      duration: Duration(microseconds: duration.toInt()),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 252 * widthRatio,
              height: 256 * heightRatio,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25 * heightRatio),
                color: MainColors.todoBackgroundColor,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 21 * heightRatio,
                horizontal: 16 * widthRatio,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'To-Do List',
                    style: MainTextTheme.todoList.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: 19 * heightRatio,
                  ),
                  Container(
                    height: 36.42384 * heightRatio,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.28 * heightRatio),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.74 * widthRatio,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 14.6 * heightRatio,
                          height: 14.6 * heightRatio,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.73 * heightRatio),
                            borderRadius: BorderRadius.circular(
                              2.19 * heightRatio,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 9.47 * widthRatio,
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
                    height: 10.58 * heightRatio,
                  ),
                  Container(
                    height: 36.42384 * heightRatio,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.28 * heightRatio),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.74 * widthRatio,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 14.6 * heightRatio,
                          height: 14.6 * heightRatio,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.73 * heightRatio),
                            borderRadius: BorderRadius.circular(
                              2.19 * heightRatio,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 9.47 * widthRatio,
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
                    height: 10.58 * heightRatio,
                  ),
                  Container(
                    height: 36.42384 * heightRatio,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.28 * heightRatio),
                      color: MainColors.todoSelectedColor,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.74 * widthRatio,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 14.6 * heightRatio,
                          height: 14.6 * heightRatio,
                          decoration: BoxDecoration(
                            color: MainColors.todoSelectedCheckBoxColor,
                            borderRadius: BorderRadius.circular(
                              2.19 * heightRatio,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 9.47 * widthRatio,
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
              height: 30 * heightRatio,
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
    // double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return AnimatedOpacity(
      opacity: (visible) ? 1 : 0,
      duration: Duration(microseconds: duration.toInt()),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 11.5 * heightRatio),
              child: SvgPicture.asset(
                'assets/icons/checkmate_timer.svg',
                height: 138,
                colorFilter: const ColorFilter.mode(
                  MainColors.tutorialColor,
                  BlendMode.srcIn,
                ),
              ),
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
    // double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return AnimatedOpacity(
      opacity: (visible) ? 1 : 0,
      duration: Duration(microseconds: duration.toInt()),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/checkmate_pomodoro.svg',
              height: 130,
              colorFilter: const ColorFilter.mode(
                MainColors.tutorialColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(
              height: 7 * heightRatio,
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
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
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
              height: 23 * heightRatio,
            ),
            Container(
              width: 170 * widthRatio,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13 * heightRatio),
                color: MainColors.textfieldNameColor,
              ),
              child: TextField(
                onChanged: onChanged,
                focusNode: focusNode,
                textAlign: TextAlign.center,
                style: MainTextTheme.input,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(13 * heightRatio),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 19 * heightRatio,
            ),
            const Text(
              '이름을 알려주기 싫다면,\n별명도 좋아요',
              style: MainTextTheme.tutorialTip,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 105 * heightRatio,
            ),
          ],
        ),
      ),
    );
  }
}
