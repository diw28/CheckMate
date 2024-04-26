import 'dart:math';

import 'package:flutter/material.dart' hide Text, TextField;
import 'package:get/get.dart';

import '../functions/todo_list.dart';
import '../screens/todo_screen.dart';
import '../static.dart';
import '../themes/color_theme.dart';
import '../themes/text_theme.dart';
import 'text.dart';

class TodoListBox extends StatelessWidget {
  final List<Todo> todos;

  const TodoListBox(
    this.todos, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return Container(
      height: 421 * heightRatio,
      decoration: BoxDecoration(
        color: MainColors.todoBackgroundColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20 * heightRatio),
      ),
      padding: EdgeInsets.only(
        top: 25 * heightRatio,
        left: 30 * widthRatio,
        right: 30 * widthRatio,
        bottom: 34 * heightRatio,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'To-Do List',
                style: MainTextTheme.todoList,
              ),
              const Expanded(
                child: SizedBox(),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => const TodoScreen(),
                    transition: Transition.rightToLeft,
                  );
                },
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 22.3,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25 * heightRatio,
          ),
          if (todos.isEmpty)
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '앗!',
                      style: MainTextTheme.todoEmptyAht,
                    ),
                    Text(
                      '할 일이 아직 등록되지 않았어요.\n만약 할 일을 등록해준다면...\n좋은 일이 생길지도 몰라요',
                      style: MainTextTheme.todoEmpty,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => TodoItem(todos[index]),
                separatorBuilder: (context, index) => SizedBox(
                  height: 14 * heightRatio,
                ),
                itemCount: min(5, todos.length),
              ),
            ),
        ],
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  const TodoItem(
    this.todo, {
    super.key,
    this.backgroundColor,
    this.detail = false,
  });
  final Todo todo;
  final Color? backgroundColor;
  final bool detail;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.todo.check = !widget.todo.check;
        });
      },
      child: AnimatedContainer(
        duration: Duration(microseconds: duration.toInt()),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10 * heightRatio,
          ),
          color: (widget.todo.check
                  ? MainColors.todoSelectedColor
                  : (widget.backgroundColor ?? Colors.white))
              .withOpacity(0.8),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10 * widthRatio,
          vertical: 13 * heightRatio,
        ),
        child: Row(
          children: [
            Container(
              width: 20 * heightRatio,
              height: 20 * heightRatio,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  3 * heightRatio,
                ),
                border: widget.todo.check
                    ? null
                    : Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                color: widget.todo.check
                    ? MainColors.todoSelectedCheckBoxColor
                    : null,
              ),
            ),
            SizedBox(
              width: 12 * widthRatio,
            ),
            Text(
              widget.todo.name,
              style: widget.todo.check
                  ? MainTextTheme.todoListItemSelected
                  : MainTextTheme.todoListItem,
            ),
            const Expanded(child: SizedBox()),
            if (widget.detail)
              GestureDetector(
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF717171),
                  size: 18.73,
                ),
              )
          ],
        ),
      ),
    );
  }
}
