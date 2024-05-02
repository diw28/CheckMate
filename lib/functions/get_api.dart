import 'dart:convert';
import '../api_key.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

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

class Weather {
  Weather._();

  static int F2C(double f) => ((f - 32) * 5 / 9).round();

  static String icon(int id, [bool day = true]) {
    if (id >= 802) return 'assets/icons/weather/cloudy.svg';
    if (id == 801 && day) return 'assets/icons/weather/partly_cloudy_day.svg';
    if (id == 801) return 'assets/icons/weather/partly_cloudy_night.svg';
    if (id == 800 && day) return 'assets/icons/weather/sunny.svg';
    if (id == 800) return 'assets/icons/weather/clear_night.svg';
    if (id >= 700) return 'assets/icons/weather/mist.svg';
    if (id >= 600) return 'assets/icons/weather/snowy.svg';
    if (id >= 512) return 'assets/icons/weather/shower_rain.svg';
    if (id == 511) return 'assets/icons/weather/snowy.svg';
    if (id >= 500) return 'assets/icons/weather/rain.svg';
    if (id >= 300) return 'assets/icons/weather/drizzle.svg';
    return 'assets/icons/weather/thunderstorm.svg';
  }

  static Future<List> getWeekly(String time) async {
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
        'max': F2C(day['temp']['max']),
        'min': F2C(day['temp']['min']),
        'icon': icon(day['weather'][0]['id']),
      });
    }
    return result;
  }

  static Future<Map> getCurrent(String time) async {
    List<double> coo = (await GPS.get()) ?? [];
    double lat = coo[0];
    double lon = coo[1];
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey');
    var response = await http.get(url);
    Map result = jsonDecode(response.body);
    return {
      'temp': {
        'curr': F2C(result['main']['temp']),
        'max': F2C(result['main']['temp_max']),
        'min': F2C(result['main']['temp_min']),
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
