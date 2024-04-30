import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class API extends GetxController {
  String breakfast = '', lunch = '', dinner = '';

  bool loading = true;

  Future<void> callAPI() async {
    print('api loaded');
    loading = false;
    update();
  }
}
