import 'dart:convert';

import 'package:http/http.dart' as http;

class Food {
  static Future<String> get(String time) async {
    final url = Uri.parse('https://api.xn--299a1v27nvthhjj.com/');
    var response = await http.get(url);
    String result = jsonDecode(response.body)[time];
    result = result.replaceAll('/', '\n');
    while ('\n'.allMatches(result).length < 10) {
      result = '$result\n';
    }
    return result;
  }
}
