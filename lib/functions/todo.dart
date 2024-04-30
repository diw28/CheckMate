import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'notification.dart';

TimeOfDay stringToTimeOfDay(String tod) {
  final format = DateFormat('h:mm a'); //"6:00 AM"
  return TimeOfDay.fromDateTime(format.parse(tod));
}

class Todo {
  String name;
  String note;
  String time;
  String? date;
  bool check;
  bool isImportant;

  Todo.fromJson(String json)
      : name = jsonDecode(json)['name'],
        note = jsonDecode(json)['note'],
        time = jsonDecode(json)['time'],
        date = jsonDecode(json)['date'],
        check = jsonDecode(json)['check'],
        isImportant = jsonDecode(json)['important'];

  String get json {
    return jsonEncode({
      'name': name,
      'note': note,
      'time': time,
      'date': date,
      'check': check,
      'important': isImportant
    });
  }

  static Future<bool> set({
    required String name,
    required String note,
    required String time,
    required bool check,
    required bool isImportant,
    String? date,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = prefs.getStringList('to_do_list') ?? [];

    if (await find(name) != null) return false;

    String json = jsonEncode({
      'name': name,
      'note': note,
      'time': time,
      'date': date,
      'check': check,
      'important': isImportant,
    });
    jsonList.add(json);
    await prefs.setStringList('to_do_list', jsonList);
    if (prefs.getBool('notice') ?? true) {
      LocalNotification.set(Todo.fromJson(json));
    }
    return true;
  }

  static Future<Todo?> find(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = prefs.getStringList('to_do_list') ?? [];

    for (String json in jsonList) {
      if (jsonDecode(json)['name'] == name) {
        return Todo.fromJson(json);
      }
    }
    return null;
  }

  static Future<List<Todo>> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> jsonList = prefs.getStringList('to_do_list') ?? [];
    List<Todo> todos = [];

    for (String json in jsonList) {
      Todo todo = Todo.fromJson(json);

      if (todo.date != null) {
        DateTime now = DateTime.now();
        DateTime midnight = DateTime(
          now.year,
          now.month,
          now.day,
        );
        DateTime date = DateTime.parse(todo.date!);

        if (date.isBefore(midnight)) {
          continue;
        }
      }
      todos.add(todo);
    }
    prefs.setStringList('to_do_list', [for (Todo t in todos) t.json]);
    return todos;
  }

  Future<bool> update({
    String? name,
    String? note,
    String? time,
    bool? check,
    bool? isImportant,
    String? date,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = prefs.getStringList('to_do_list') ?? [];
    List<String> result = [];

    for (String json in jsonList) {
      if (jsonDecode(json)['name'] != this.name) {
        result.add(json);
      } else {
        result.add(
          jsonEncode({
            'name': name ?? this.name,
            'note': note ?? this.note,
            'time': time ?? this.time,
            'date': date ?? this.date,
            'check': check ?? this.check,
            'important': isImportant ?? this.isImportant,
          }),
        );
      }
    }

    this.name = name ?? this.name;
    this.note = note ?? this.note;
    this.time = time ?? this.time;
    this.date = date ?? this.date;
    this.check = check ?? this.check;
    this.isImportant = isImportant ?? this.isImportant;

    if (prefs.getBool('notice') ?? true) {
      await LocalNotification.cancel(name ?? this.name);
      LocalNotification.set(this);
    }

    await prefs.setStringList('to_do_list', result);

    return true;
  }

  Future<void> remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = prefs.getStringList('to_do_list') ?? [];
    List<String> result = [];

    for (String json in jsonList) {
      if (jsonDecode(json)['name'] != name) {
        result.add(json);
      }
    }

    await prefs.setStringList('to_do_list', result);

    LocalNotification.cancel(name);
  }
}
