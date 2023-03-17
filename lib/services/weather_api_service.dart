import 'dart:developer';
import 'package:ferry_app/models/weatherdatamodel.dart';
import 'package:http/http.dart' as http;

class WeatherApiService {
  Future<List<WeatherData>?> getWeatherData() async {
    try {
      var url = Uri.parse(
          'http://192.168.1.186:3001/weather/millport/largs/2023-03-20');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<WeatherData> _model = weatherDataFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
