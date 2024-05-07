import 'package:flutter/material.dart' hide Text, TextField;

import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:check_mate/functions/todo.dart';

import '../widgets/text.dart' show Text, TextField;
import '../themes/text_theme.dart';
import '../themes/color_theme.dart';

class TodoDetailScreen extends StatefulWidget {
  final Todo todo;
  const TodoDetailScreen(this.todo, {super.key});

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  late String name;
  late String note;
  late bool isImportant;
  late TimeOfDay time;

  @override
  void initState() {
    super.initState();
    setState(() {
      name = widget.todo.name;
      note = widget.todo.note;
      isImportant = widget.todo.isImportant;
      time = stringToTimeOfDay(widget.todo.time);
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return GestureDetector(
      onTap: () {
        focusNode1.unfocus();
        focusNode2.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 51 * heightRatio,
              left: 34 * widthRatio,
              right: 34 * widthRatio,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        'assets/icons/checkmate_todo.svg',
                        height: 24.17,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(
                        width: 11 * widthRatio,
                      ),
                      Text(
                        name,
                        style: MainTextTheme.pageTitle,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 59 * heightRatio,
                ),
                const Text(
                  'Title',
                  style: MainTextTheme.addTodoTitle,
                ),
                SizedBox(
                  height: 7 * heightRatio,
                ),
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18 * heightRatio),
                    color: MainColors.textfieldNameColor,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    onChanged: (p0) {
                      setState(() {
                        name = p0;
                      });
                    },
                    focusNode: focusNode1,
                    style: MainTextTheme.addTodoInput,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(18 * heightRatio),
                      ),
                      hintText: name,
                      hintStyle: MainTextTheme.addTodoHint,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12 * heightRatio,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        isImportant = !isImportant;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 8,
                          bottom: 9,
                          left: 9 * widthRatio,
                          right: 12 * widthRatio,
                        ),
                        decoration: BoxDecoration(
                          color: isImportant
                              ? MainColors.addTodoImportance
                              : Colors.white,
                          border: Border.all(
                            color: MainColors.addTodoImportance,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/add_todo/importance.svg',
                              width: 20,
                              colorFilter: ColorFilter.mode(
                                isImportant
                                    ? Colors.white
                                    : MainColors.addTodoImportance,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(
                              width: 2 * widthRatio,
                            ),
                            Text(
                              '중요',
                              style: isImportant
                                  ? MainTextTheme.addTodoImportance.copyWith(
                                      color: Colors.white,
                                    )
                                  : MainTextTheme.addTodoImportance,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10 * widthRatio,
                    ),
                    GestureDetector(
                      onTap: () async {
                        time = await showTimePicker(
                              context: context,
                              initialTime: const TimeOfDay(hour: 0, minute: 0),
                            ) ??
                            const TimeOfDay(hour: 0, minute: 0);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 8,
                          bottom: 9,
                          left: 8 * widthRatio,
                          right: 8 * widthRatio,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: MainColors.addTodoTime,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/add_todo/time.svg',
                              width: 22,
                              colorFilter: const ColorFilter.mode(
                                MainColors.addTodoTime,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(
                              width: 5 * widthRatio,
                            ),
                            Text(
                              time.format(context),
                              style: MainTextTheme.addTodoTime,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 61 * heightRatio,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12 * widthRatio),
                  child: const Text(
                    'Notes',
                    style: MainTextTheme.addTodoTitle,
                  ),
                ),
                SizedBox(
                  height: 7 * heightRatio,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18 * heightRatio),
                    color: MainColors.textfieldNameColor,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 15 * widthRatio,
                    vertical: 16 * heightRatio,
                  ),
                  child: TextField(
                    onChanged: (p0) {
                      setState(() {
                        note = p0;
                      });
                    },
                    focusNode: focusNode2,
                    maxLines: 10,
                    style: MainTextTheme.addTodoInput,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(18 * heightRatio),
                      ),
                      hintText: note,
                      hintStyle: MainTextTheme.addTodoHint,
                    ),
                  ),
                ),
                SizedBox(
                  height: 102 * heightRatio,
                ),
                GestureDetector(
                  onTap: () async {
                    if (name.isEmpty) {
                      Get.closeAllSnackbars();
                      Get.snackbar(
                        'error',
                        'type the name of task to do',
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(milliseconds: 1500),
                      );
                    } else {
                      bool updateCompleted = await widget.todo.update(
                        name: name,
                        note: note,
                        time: time.format(context),
                        check: false,
                        isImportant: isImportant,
                      );
                      if (!updateCompleted) {
                        Get.closeAllSnackbars();
                        Get.snackbar(
                          'warning',
                          "'$name' already exists.",
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(milliseconds: 1500),
                        );
                        return;
                      }

                      Get.back();
                      Get.closeAllSnackbars();
                      Get.snackbar(
                        'success',
                        "'$name' was updated successfully.",
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(milliseconds: 1500),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14 * heightRatio),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50 * heightRatio),
                      color: MainColors.highlightColor,
                    ),
                    child: const Center(
                      child: Text(
                        '수정',
                        style: MainTextTheme.button,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10 * heightRatio,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
