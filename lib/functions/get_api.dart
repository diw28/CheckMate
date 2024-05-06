import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import '../api_key.dart';

class Food {
  Food._();

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

class Weather extends GetxController {
  Weather._();
  List weekly = [];
  Map current = {};
  static Future<Weather> init() async {
    Weather w = Weather._();
    w.weekly = await _Weather.getWeekly();
    w.current = await _Weather.getCurrent();
    return w;
  }

  Future<void> updateData() async {
    weekly = await _Weather.getWeekly();
    current = await _Weather.getCurrent();
    update();
  }
}

class _Weather {
  _Weather._();

  // ignore: non_constant_identifier_names
  static int K2C(double k) => (k - 273.15).round();

  static String icon(int id, [bool day = true]) {
    if (id >= 802) return 'cloudy';
    if (id == 801 && day) return 'partly_cloudy_day';
    if (id == 801) return 'partly_cloudy_night';
    if (id == 800 && day) return 'sunny';
    if (id == 800) return 'clear_night';
    if (id >= 700) return 'mist';
    if (id >= 600) return 'snowy';
    if (id >= 512) return 'shower_rain';
    if (id == 511) return 'snowy';
    if (id >= 500) return 'rain';
    if (id >= 300) return 'drizzle';
    return 'thunderstorm';
  }

  static Future<List> getWeekly() async {
    List<double> coo = (await GPS.get()) ?? [];
    double lat = coo[0];
    double lon = coo[1];
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast/daily?lat=$lat&lon=$lon&cnt=7&appid=$apiKey');
    var response = await http.get(url);
    List<Map> list = jsonDecode(response.body)['list'];
    List<Map> result = [];
    for (Map day in list) {
      result.add({
        'max': K2C(day['temp']['max']),
        'min': K2C(day['temp']['min']),
        'icon': icon(day['weather'][0]['id']),
      });
    }
    return result;
  }

  static Future<Map> getCurrent() async {
    List<double> coo = (await GPS.get()) ?? [];
    double lat = coo[0];
    double lon = coo[1];
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey');
    var response = await http.get(url);
    Map result = jsonDecode(response.body);
    return {
      'temp': {
        'curr': K2C(result['main']['temp']),
        'max': K2C(result['main']['temp_max']),
        'min': K2C(result['main']['temp_min']),
      },
      'weather': result['weather'][0]['main'],
      'icon': icon(result['weather'][0]['id']),
    };
  }
}

class GPS {
  GPS._();

  static Future<List<double>?> get() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    locationData = await location.getLocation();
    return [locationData.latitude!, locationData.longitude!];
  }
}
