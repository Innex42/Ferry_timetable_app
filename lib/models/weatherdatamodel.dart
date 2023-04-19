import 'dart:convert';

import 'package:flutter/material.dart';

// converts data from JSON
List<WeatherData> weatherDataFromJson(String str) => List<WeatherData>.from(
    json.decode(str).map((x) => WeatherData.fromJson(x)));

//converts data to JSON
String weatherDataToJson(List<WeatherData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//Define each variable to be retrieved from JSON
class WeatherData {
  WeatherData({
    required this.datetime,
    required this.windgust,
    required this.windspeed,
  });

  TimeOfDay datetime;
  String windgust;
  String windspeed;

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        datetime: TimeOfDay.fromDateTime(DateTime.parse(json["datetime"])),
        windgust: json["windgust"],
        windspeed: json["windspeed"],
      );

  Map<String, dynamic> toJson() => {
        "datetimeEpoch": datetime,
        "windgust": windgust,
        "windspeed": windspeed,
      };
}
