// To parse this JSON data, do
//
//     final ferryTimes = ferryTimesFromJson(jsonString);

import 'dart:convert';

List<FerryTimes> ferryTimesFromJson(String str) =>
    List<FerryTimes>.from(json.decode(str).map((x) => FerryTimes.fromJson(x)));

String ferryTimesToJson(List<FerryTimes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FerryTimes {
  FerryTimes({
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
  });

  String departureTime;
  String arrivalTime;
  String duration;

  factory FerryTimes.fromJson(Map<String, dynamic> json) => FerryTimes(
        departureTime: json["departureTime"],
        arrivalTime: json["arrivalTime"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "departureTime": departureTime,
        "arrivalTime": arrivalTime,
        "duration": duration,
      };
}
