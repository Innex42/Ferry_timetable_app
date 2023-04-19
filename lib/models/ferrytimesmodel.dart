import 'dart:convert';

import 'package:flutter/material.dart';

// converts data from JSON
List<FerryTimes> ferryTimesFromJson(String str) =>
    List<FerryTimes>.from(json.decode(str).map((x) => FerryTimes.fromJson(x)));

//converts data to JSON
String ferryTimesToJson(List<FerryTimes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//Define each variable to be retrieved from JSON
class FerryTimes {
  FerryTimes({
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
  });

  TimeOfDay departureTime;
  TimeOfDay arrivalTime;
  String duration;

  factory FerryTimes.fromJson(Map<String, dynamic> json) => FerryTimes(
        //Convert 24hr string to TimeOfDay
        departureTime: TimeOfDay(
            hour: int.parse(json["departureTime"].split(":")[0]),
            minute: int.parse(json["departureTime"].split(":")[1])),
        //Convert 24hr string to TimeOfDay
        arrivalTime: TimeOfDay(
            hour: int.parse(json["arrivalTime"].split(":")[0]),
            minute: int.parse(json["arrivalTime"].split(":")[1])),
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "departureTime": departureTime,
        "arrivalTime": arrivalTime,
        "duration": duration,
      };
}
