import 'package:flutter/material.dart' hide Text, TextField;

import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/text.dart' show Text;
import '../themes/color_theme.dart';
import '../themes/text_theme.dart';

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
