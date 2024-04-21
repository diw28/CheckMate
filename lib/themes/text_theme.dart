import 'package:flutter/material.dart';
import 'color_theme.dart';

abstract class MainTextTheme {
  static const tutorialTitle = TextStyle(
    color: Colors.white,
    fontSize: 26,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 31 / 26,
  );
  static const tutorialSlogan = TextStyle(
    color: Color(0xFF005585),
    fontSize: 50,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
  );
  static const tutorialText = TextStyle(
    color: TextColors.tutorialText,
    fontSize: 26,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 31 / 26,
  );
  static const tutorialTip = TextStyle(
    color: TextColors.tutorialTip,
    fontSize: 17,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 21 / 17,
  );
  static const tutorialInput = TextStyle(
    color: Colors.black,
    fontSize: 19,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 23 / 19,
  );
  static const button = TextStyle(
    color: Colors.white,
    fontSize: 25,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
  );
  static const todoList = TextStyle(
    color: Colors.black,
    fontSize: 23,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 27 / 23,
  );
  static const todoListItem = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 24 / 20,
  );
  static const todoListItemSelected = TextStyle(
    color: TextColors.todoListSelected,
    fontSize: 20,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 24 / 20,
    decoration: TextDecoration.lineThrough,
    decorationColor: TextColors.todoListSelected,
  );
}
