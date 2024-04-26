import 'package:check_mate/static.dart';
import 'package:check_mate/themes/color_theme.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final bool active;
  const ToggleButton(this.active, {super.key});

  @override
  Widget build(BuildContext context) {
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return AnimatedContainer(
      duration: Duration(
        microseconds: duration.toInt(),
      ),
      curve: Curves.ease,
      width: 40 * heightRatio,
      height: 20 * heightRatio,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20 * heightRatio,
        ),
        color: active
            ? MainColors.toggleBackgroundActive
            : MainColors.toggleBackground,
      ),
      padding: EdgeInsets.all(
        2 * heightRatio,
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: Duration(
              microseconds: duration.toInt(),
            ),
            curve: Curves.ease,
            width: active ? 20 * heightRatio : 0,
          ),
          Container(
            width: 16 * heightRatio,
            height: 16 * heightRatio,
            decoration: const ShapeDecoration(
              shape: CircleBorder(),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
