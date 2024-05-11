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
  static const input = TextStyle(
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
    fontSize: 21,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 25 / 21,
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
    color: TextColors.textfieldHint,
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
  static const pomodoroCount = TextStyle(
    color: TextColors.pomodoroCount,
    fontSize: 40,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 48 / 40,
  );
  static const settingTitle = TextStyle(
    color: Colors.black,
    fontSize: 19,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    height: 23 / 19,
  );
  static const settingText = TextStyle(
    color: TextColors.settingText,
    fontSize: 14,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    height: 17 / 14,
  );
  static const creditText = TextStyle(
    color: TextColors.creditText,
    fontSize: 14,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    height: 17 / 14,
  );
  static const todoImportant = TextStyle(
    color: TextColors.settingText,
    fontSize: 20,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    height: 24 / 20,
  );
  static const todoEmptyAht = TextStyle(
    color: TextColors.todoEmpty,
    fontSize: 40,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w900,
    height: 48 / 40,
  );
  static const todoEmpty = TextStyle(
    color: TextColors.todoEmpty,
    fontSize: 17,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w300,
    height: 20 / 17,
  );
  static const foodTitleBreakfast = TextStyle(
    color: TextColors.foodTitleBreakfast,
    fontSize: 45,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    height: 54 / 45,
  );
  static const foodTitleLunch = TextStyle(
    color: TextColors.foodLunch,
    fontSize: 45,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    height: 54 / 45,
  );
  static const foodTitleDinner = TextStyle(
    color: TextColors.foodDinner,
    fontSize: 45,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    height: 54 / 45,
  );
  static const foodTextBreakfast = TextStyle(
    color: TextColors.foodBreakfast,
    fontSize: 18,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    height: 31 / 18,
  );
  static const foodTextLunch = TextStyle(
    color: TextColors.foodLunch,
    fontSize: 18,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    height: 31 / 18,
  );
  static const foodTextDinner = TextStyle(
    color: TextColors.foodDinner,
    fontSize: 18,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    height: 31 / 18,
  );
  static const foodTip = TextStyle(
    color: TextColors.tutorialTip,
    fontSize: 17,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 21 / 17,
  );
  static const weatherCurrentMain = TextStyle(
    color: Colors.white,
    fontSize: 43,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    height: 51 / 43,
  );
  static const weatherCurrentTemp = TextStyle(
    color: Colors.white,
    fontSize: 90,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 109 / 90,
  );
  static const weatherCurrentDegree = TextStyle(
    color: Colors.white,
    fontSize: 40,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w300,
    height: 48 / 40,
  );
  static const weatherCurrentMaxMin = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 36 / 30,
  );
  static const weatherWeeklyTitle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    height: 29 / 24,
  );
  static const weatherWeeklyWeekDay = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    height: 24 / 20,
  );
  static const weatherWeeklyMaxMin = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 29 / 24,
  );
}
