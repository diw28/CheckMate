import 'package:flutter/material.dart' hide Text, TextField;

import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../functions/get_api.dart';
import '../static.dart';
import '../widgets/text.dart' show Text, TextField;
import '../themes/text_theme.dart';
import '../themes/color_theme.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  String text = '';
  // String time = 'breakfast';
  int time = 0;

  List<String> times = ['breakfast', 'lunch', 'dinner'];

  Future<void> getAPI() async {
    text = await Food.get(times[time]);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAPI();
  }

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return Scaffold(
      body: GestureDetector(
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
                      'assets/icons/checkmate_foodicon.svg',
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(
                      width: 7 * widthRatio,
                    ),
                    const Text(
                      '디미고급식',
                      style: MainTextTheme.pageTitle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 102 * heightRatio,
              ),
              GestureDetector(
                onTap: () async {
                  time = (time + 1) % 3;
                  await getAPI();
                  setState(() {});
                },
                child: AnimatedContainer(
                  duration: Duration(microseconds: duration.toInt()),
                  curve: Curves.linear,
                  width: 313 * widthRatio,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30 * widthRatio),
                    color: time == 0
                        ? MainColors.foodBackgroundBreakfast
                        : time == 1
                            ? MainColors.foodBackgroundlunch
                            : MainColors.foodBackgroundDinner,
                  ),
                  padding: EdgeInsets.only(
                    left: 24 * widthRatio,
                    right: 24 * widthRatio,
                    top: 28 * heightRatio,
                    bottom: 23 * heightRatio,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          AnimatedOpacity(
                            duration: Duration(microseconds: duration.toInt()),
                            opacity: time == 0 ? 1 : 0,
                            curve: Curves.linear,
                            child: const Text(
                              '아침',
                              style: MainTextTheme.foodTitleBreakfast,
                            ),
                          ),
                          AnimatedOpacity(
                            duration: Duration(microseconds: duration.toInt()),
                            opacity: time == 1 ? 1 : 0,
                            curve: Curves.linear,
                            child: const Text(
                              '점심',
                              style: MainTextTheme.foodTitleLunch,
                            ),
                          ),
                          AnimatedOpacity(
                            duration: Duration(microseconds: duration.toInt()),
                            opacity: time == 2 ? 1 : 0,
                            curve: Curves.linear,
                            child: const Text(
                              '저녁',
                              style: MainTextTheme.foodTitleDinner,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 27 * heightRatio,
                      ),
                      Stack(
                        children: [
                          AnimatedOpacity(
                            duration: Duration(microseconds: duration.toInt()),
                            opacity: time == 0 ? 1 : 0,
                            curve: Curves.linear,
                            child: Text(
                              text,
                              maxLines: 11,
                              style: MainTextTheme.foodTextBreakfast,
                            ),
                          ),
                          AnimatedOpacity(
                            duration: Duration(microseconds: duration.toInt()),
                            opacity: time == 1 ? 1 : 0,
                            curve: Curves.linear,
                            child: Text(
                              text,
                              maxLines: 11,
                              style: MainTextTheme.foodTextLunch,
                            ),
                          ),
                          AnimatedOpacity(
                            duration: Duration(microseconds: duration.toInt()),
                            opacity: time == 2 ? 1 : 0,
                            curve: Curves.linear,
                            child: Text(
                              text,
                              maxLines: 11,
                              style: MainTextTheme.foodTextDinner,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                flex: 148,
                child: SizedBox(),
              ),
              const Text(
                'Powered by 디미고급식.com',
                style: MainTextTheme.foodTip,
              ),
              const Expanded(
                flex: 87,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
