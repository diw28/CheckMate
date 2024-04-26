import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'notification.dart';

TimeOfDay stringToTimeOfDay(String tod) {
  final format = DateFormat.jm(); //"6:00 AM"
  return TimeOfDay.fromDateTime(format.parse(tod));
}

class Todo {
  String name;
  String note;
  String time;
  bool check;
  bool isImportant;

  Todo.fromJson(String json)
      : name = jsonDecode(json)['name'],
        note = jsonDecode(json)['note'],
        time = jsonDecode(json)['time'],
        check = jsonDecode(json)['check'],
        isImportant = jsonDecode(json)['important'];

  String get json {
    return jsonEncode({
      'name': name,
      'note': note,
      'time': time,
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
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = prefs.getStringList('to_do_list') ?? [];

    if (await find(name) != null) return false;

    String json = jsonEncode({
      'name': name,
      'note': note,
      'time': time,
      'check': check,
      'important': isImportant,
    });
    jsonList.add(json);
    await prefs.setStringList('to_do_list', jsonList);

    if (prefs.getBool('notice') ?? false) {
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

    return [for (String json in jsonList) Todo.fromJson(json)];
  }

  Future<bool> update({
    required String name,
    required String note,
    required String time,
    required bool check,
    required bool isImportant,
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
            'name': name,
            'note': note,
            'time': time,
            'check': check,
            'important': isImportant,
          }),
        );
      }
    }

    this.name = name;
    this.note = note;
    this.time = time;
    this.check = check;
    this.isImportant = isImportant;

    if (prefs.getBool('notice') ?? false) {
      await LocalNotification.cancel(name);
      LocalNotification.set(this);
    }

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
