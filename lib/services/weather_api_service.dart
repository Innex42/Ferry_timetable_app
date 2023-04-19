import 'dart:developer';
import 'package:ferry_app/models/weatherdatamodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class WeatherApiService {
  Future<List<WeatherData>?> getWeatherData(
      DateTime day, String departurePoint, String arrivalPoint) async {
    debugPrint(
        "${ApiConstants.weatherApiUrlStart}/$departurePoint/$arrivalPoint${day.year}-${day.month}-${day.day}");

    //Http request for the Weather data with request parameters (departure point, arrival point, date of travel)
    try {
      var url = Uri.parse(
          "${ApiConstants.weatherApiUrlStart}/$departurePoint/$arrivalPoint/${day.year}-${day.month}-${day.day}");
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
