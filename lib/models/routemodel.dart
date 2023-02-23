// To parse this JSON data, do
//
//     final routeModel = routeModelFromJson(jsonString);

import 'dart:convert';

RouteModel routeModelFromJson(String str) =>
    RouteModel.fromJson(json.decode(str));

String routeModelToJson(RouteModel data) => json.encode(data.toJson());

class RouteModel {
  RouteModel({
    required this.routeId,
    required this.routeDeparturePoint,
    required this.routeDestination,
    required this.timetables,
  });

  String routeId;
  String routeDeparturePoint;
  String routeDestination;
  List<Timetable> timetables;

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
        routeId: json["routeID"],
        routeDeparturePoint: json["routeDeparturePoint"],
        routeDestination: json["routeDestination"],
        timetables: List<Timetable>.from(
            json["timetables"].map((x) => Timetable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "routeID": routeId,
        "routeDeparturePoint": routeDeparturePoint,
        "routeDestination": routeDestination,
        "timetables": List<dynamic>.from(timetables.map((x) => x.toJson())),
      };
}

class Timetable {
  Timetable({
    required this.timetableId,
    required this.timetableType,
    required this.timetableOperationStart,
    required this.timetableOperationEnd,
    required this.timetablesByDay,
  });

  int timetableId;
  String timetableType;
  DateTime timetableOperationStart;
  DateTime timetableOperationEnd;
  List<TimetablesByDay> timetablesByDay;

  factory Timetable.fromJson(Map<String, dynamic> json) => Timetable(
        timetableId: json["timetableID"],
        timetableType: json["timetableType"],
        timetableOperationStart:
            DateTime.parse(json["timetableOperationStart"]),
        timetableOperationEnd: DateTime.parse(json["timetableOperationEnd"]),
        timetablesByDay: List<TimetablesByDay>.from(
            json["timetablesByDay"].map((x) => TimetablesByDay.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timetableID": timetableId,
        "timetableType": timetableType,
        "timetableOperationStart": timetableOperationStart.toIso8601String(),
        "timetableOperationEnd": timetableOperationEnd.toIso8601String(),
        "timetablesByDay":
            List<dynamic>.from(timetablesByDay.map((x) => x.toJson())),
      };
}

class TimetablesByDay {
  TimetablesByDay({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  List<Day>? monday;
  List<Day>? tuesday;
  List<Day>? wednesday;
  List<Day>? thursday;
  List<Day>? friday;
  List<Day>? saturday;
  List<Day>? sunday;

  factory TimetablesByDay.fromJson(Map<String, dynamic> json) =>
      TimetablesByDay(
        monday: json["monday"] == null
            ? []
            : List<Day>.from(json["monday"]!.map((x) => Day.fromJson(x))),
        tuesday: json["tuesday"] == null
            ? []
            : List<Day>.from(json["tuesday"]!.map((x) => Day.fromJson(x))),
        wednesday: json["wednesday"] == null
            ? []
            : List<Day>.from(json["wednesday"]!.map((x) => Day.fromJson(x))),
        thursday: json["thursday"] == null
            ? []
            : List<Day>.from(json["thursday"]!.map((x) => Day.fromJson(x))),
        friday: json["friday"] == null
            ? []
            : List<Day>.from(json["friday"]!.map((x) => Day.fromJson(x))),
        saturday: json["saturday"] == null
            ? []
            : List<Day>.from(json["saturday"]!.map((x) => Day.fromJson(x))),
        sunday: json["sunday"] == null
            ? []
            : List<Day>.from(json["sunday"]!.map((x) => Day.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "monday": monday == null
            ? []
            : List<dynamic>.from(monday!.map((x) => x.toJson())),
        "tuesday": tuesday == null
            ? []
            : List<dynamic>.from(tuesday!.map((x) => x.toJson())),
        "wednesday": wednesday == null
            ? []
            : List<dynamic>.from(wednesday!.map((x) => x.toJson())),
        "thursday": thursday == null
            ? []
            : List<dynamic>.from(thursday!.map((x) => x.toJson())),
        "friday": friday == null
            ? []
            : List<dynamic>.from(friday!.map((x) => x.toJson())),
        "saturday": saturday == null
            ? []
            : List<dynamic>.from(saturday!.map((x) => x.toJson())),
        "sunday": sunday == null
            ? []
            : List<dynamic>.from(sunday!.map((x) => x.toJson())),
      };
}

class Day {
  Day({
    required this.departureTimes,
    required this.arrivalTimes,
  });

  List<String> departureTimes;
  List<String> arrivalTimes;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        departureTimes: List<String>.from(json["departureTimes"].map((x) => x)),
        arrivalTimes: List<String>.from(json["arrivalTimes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "departureTimes": List<dynamic>.from(departureTimes.map((x) => x)),
        "arrivalTimes": List<dynamic>.from(arrivalTimes.map((x) => x)),
      };
}
