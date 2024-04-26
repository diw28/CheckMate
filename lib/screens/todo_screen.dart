import 'dart:math';

import 'package:flutter/material.dart' hide Text, TextField;

import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../functions/todo_list.dart';
import '../themes/text_theme.dart';
import '../themes/color_theme.dart';
import '../widgets/text.dart';
import '../widgets/todo_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Todo> todos_important = [], todos_not = [];
  Future<void> getTodo() async {
    for (Todo todo in await Todo.getAll()) {
      if (todo.isImportant) {
        todos_important.add(todo);
      } else {
        todos_not.add(todo);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTodo();
  }

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return Scaffold(
      body: SingleChildScrollView(
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
                      'assets/icons/checkmate_settings.svg',
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(
                      width: 7.86 * widthRatio,
                    ),
                    const Text(
                      '할 일',
                      style: MainTextTheme.pageTitle,
                    ),
                  ],
                ),
              ),
              if (todos_important.isEmpty && todos_not.isEmpty)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 320 * heightRatio,
                      ),
                      Text(
                        '앗!',
                        style: MainTextTheme.todoEmptyAht.copyWith(
                          fontSize: 50,
                          height: 60 / 50,
                        ),
                      ),
                      Text(
                        '할 일이 아직 등록되지 않았어요.\n만약 할 일을 등록해준다면...\n좋은 일이 생길지도 몰라요',
                        style: MainTextTheme.todoEmpty.copyWith(
                          fontSize: 20,
                          height: 24 / 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: [
                    SizedBox(
                      height: 46 * heightRatio,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 11 * widthRatio,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 2,
                              color: MainColors.indicatorColor,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.only(
                          bottom: 4 * heightRatio,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5 * widthRatio,
                            ),
                            SvgPicture.asset(
                              'assets/icons/add_todo/importance.svg',
                              colorFilter: const ColorFilter.mode(
                                TextColors.todoDetailImportant,
                                BlendMode.srcIn,
                              ),
                              width: 20 / 18.33 * 18,
                            ),
                            SizedBox(
                              width: 4 * widthRatio,
                            ),
                            const Text(
                              '중요',
                              style: MainTextTheme.todoDetailImportant,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15 * heightRatio,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 11 * widthRatio,
                      ),
                      itemBuilder: (context, index) => TodoItem(
                        todos_important[index],
                        backgroundColor: const Color(0xFFF2F2F2),
                        detail: true,
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15 * heightRatio,
                      ),
                      itemCount: todos_important.length,
                    ),
                    SizedBox(
                      height: 25 * heightRatio,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 11 * widthRatio),
                      child: const Divider(
                        thickness: 2,
                        color: MainColors.indicatorColor,
                      ),
                    ),
                    SizedBox(
                      height: 15 * heightRatio,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 11 * widthRatio,
                      ),
                      itemBuilder: (context, index) => TodoItem(
                        todos_not[index],
                        backgroundColor: const Color(0xFFF2F2F2),
                        detail: true,
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15 * heightRatio,
                      ),
                      itemCount: todos_not.length,
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
