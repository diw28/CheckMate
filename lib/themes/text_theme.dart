import 'package:flutter/material.dart';
import 'color_theme.dart';

abstract class MainTextTheme {
  static const button = TextStyle(
    color: Colors.white,
    fontSize: 25,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 30 / 25,
  );
  static const pageTitle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 24 / 20,
  );
  static const tutorialTitle = TextStyle(
    color: Colors.white,
    fontSize: 26,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 31 / 26,
  );
  static const tutorialSlogan = TextStyle(
    color: TextColors.tutorialSlogan,
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
  static const homeScreenTitle = TextStyle(
    color: Colors.white,
    fontSize: 23,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 28 / 23,
  );
  static const homeScreenButton = TextStyle(
    color: Colors.black,
    fontSize: 17,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 21 / 17,
  );
  static const addTodoInput = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 18 / 15,
  );
  static const addTodoHint = TextStyle(
    color: Color(0xFF6F6F6F),
    fontSize: 15,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 18 / 15,
  );
  static const addTodoImportance = TextStyle(
    color: MainColors.addTodoImportance,
    fontSize: 15,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 18 / 15,
  );
  static const addTodoTime = TextStyle(
    color: MainColors.addTodoTime,
    fontSize: 15,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 18 / 15,
  );
  static const addTodoTitle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 24 / 20,
  );
  static const timerText = TextStyle(
    color: MainColors.highlightColor,
    fontSize: 45,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 54 / 45,
  );
}
