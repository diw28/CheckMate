import 'package:flutter/material.dart' hide Text, TextField;

import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../functions/get_api.dart';
import '../widgets/text.dart' show Text;
import '../themes/text_theme.dart';
import '../themes/color_theme.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<String> days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
  int weekDay = DateTime.now().weekday;
  int hour = DateTime.now().hour;
  String time = '';
  Weather weather = Get.find<Weather>();
  late Map current;
  late List<Map> weekly;

  @override
  void initState() {
    super.initState();
    current = weather.current;
    weekly = weather.weekly.cast<Map>();
  }

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            if (time == 'day')
              MainColors.weatherDayTop
            else if (time == 'even')
              MainColors.weatherEvenTop
            else if (time == 'dawn')
              MainColors.weatherDawnTop
            else
              MainColors.weatherNightTop,
            if (time == 'day')
              MainColors.weatherDayBottom
            else if (time == 'even')
              MainColors.weatherEvenBottom
            else if (time == 'dawn')
              MainColors.weatherDawnBottom
            else
              MainColors.weatherNightBottom,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 48 * heightRatio,
              left: 34 * widthRatio,
              right: 34 * widthRatio,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                        child: SizedBox(
                          width: 23,
                          height: 23,
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 23,
                            color: time == 'day'
                                ? MainColors.weatherDayTop
                                : time == 'even'
                                    ? MainColors.weatherEvenTop
                                    : time == 'dawn'
                                        ? MainColors.weatherDawnTop
                                        : MainColors.weatherNightText,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      SvgPicture.asset(
                        'assets/icons/weather/${current['icon']}.svg',
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          time == 'day'
                              ? MainColors.weatherDayText
                              : time == 'even'
                                  ? MainColors.weatherEvenText
                                  : time == 'dawn'
                                      ? MainColors.weatherDawnText
                                      : MainColors.weatherNightText,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(
                        width: 11 * widthRatio,
                      ),
                      Text(
                        '날씨',
                        style: MainTextTheme.pageTitle.copyWith(
                          fontWeight: FontWeight.w700,
                          color: time == 'day'
                              ? MainColors.weatherDayText
                              : time == 'even'
                                  ? MainColors.weatherEvenText
                                  : time == 'dawn'
                                      ? MainColors.weatherDawnText
                                      : MainColors.weatherNightText,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 69 * heightRatio,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 7 * widthRatio,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/weather/${current['icon']}.svg',
                            width: 120 * widthRatio,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(
                            height: 11 * heightRatio,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                current['weather'],
                                style:
                                    MainTextTheme.weatherCurrentMain.copyWith(
                                  fontSize: 43 * widthRatio,
                                ),
                              ),
                              SizedBox(
                                width: 3 * widthRatio,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 33 * heightRatio,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${current['temp']['curr']}',
                                style:
                                    MainTextTheme.weatherCurrentTemp.copyWith(
                                  fontSize: 90 * widthRatio,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 15 * widthRatio,
                                ),
                                child: Text(
                                  '℃',
                                  style: MainTextTheme.weatherCurrentDegree
                                      .copyWith(
                                    fontSize: 40 * widthRatio,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 11 * heightRatio,
                          ),
                          Text(
                            '${current['temp']['max']}℃ / ${current['temp']['min']}℃',
                            style: MainTextTheme.weatherCurrentMaxMin.copyWith(
                              fontSize: 30 * widthRatio,
                            ),
                          ),
                          SizedBox(
                            height: 3 * heightRatio,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 29 * heightRatio,
                ),
                const Text(
                  '일주일 날씨 정보',
                  style: MainTextTheme.weatherWeeklyTitle,
                ),
                SizedBox(
                  height: 12 * heightRatio,
                ),
                ListView.separated(
                  itemCount: 7,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        16 * heightRatio,
                      ),
                      color: Colors.white.withOpacity(0.4),
                    ),
                    padding: EdgeInsets.only(
                      top: 11 * heightRatio,
                      bottom: 10 * heightRatio,
                      left: 20 * widthRatio,
                      right: 15 * widthRatio,
                    ),
                    child: Row(
                      children: [
                        Text(
                          days[(weekDay + index) % 7 * 1],
                          style: MainTextTheme.weatherWeeklyWeekDay.copyWith(
                            fontSize: 20 * widthRatio,
                            color: (weekDay + index) % 7 == 0
                                ? const Color(0xFFFF5858)
                                : (weekDay + index) % 7 == 6
                                    ? const Color(0xFF6B7AFF)
                                    : Colors.white,
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        SvgPicture.asset(
                          'assets/icons/weather/${weekly[index]['icon']}.svg',
                          height: 28 * widthRatio,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(
                          width: 15 * widthRatio,
                        ),
                        Text(
                          '${weekly[index]['max']}℃ / ${weekly[index]['min']}℃',
                          style: MainTextTheme.weatherWeeklyMaxMin.copyWith(
                            fontSize: 24 * widthRatio,
                          ),
                        ),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 12 * heightRatio,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
