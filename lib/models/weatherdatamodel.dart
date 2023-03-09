// To parse this JSON data, do
//
//     final weatherData = weatherDataFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

List<WeatherData> weatherDataFromJson(String str) => List<WeatherData>.from(
    json.decode(str).map((x) => WeatherData.fromJson(x)));

String weatherDataToJson(List<WeatherData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
        datetime: TimeOfDay.fromDateTime(DateTime.fromMicrosecondsSinceEpoch(
            int.parse(json["datetimeEpoch"]))),
        windgust: json["windgust"],
        windspeed: json["windspeed"],
      );

  Map<String, dynamic> toJson() => {
        "datetimeEpoch": datetime,
        "windgust": windgust,
        "windspeed": windspeed,
      };
}
