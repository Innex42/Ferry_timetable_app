import 'dart:convert';

List<RouteModel> routeModelFromJson(String str) =>
    List<RouteModel>.from(json.decode(str).map((x) => RouteModel.fromJson(x)));

String routeModelToJson(List<RouteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RouteModel {
  RouteModel({
    required this.routeID,
    required this.routeDeparturePoint,
    required this.routeDestination,
    required this.timetables,
  });

  String routeID;
  String routeDeparturePoint;
  String routeDestination;
  Timetables timetables;

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
      routeID: json["routeID"],
      routeDeparturePoint: json["routeDeparturePoint"],
      routeDestination: json["routeDestination"],
      timetables: Timetables.fromJson(json["timetables"]));

  Map<String, dynamic> toJson() => {
        "routeid": routeID,
        "routeDeparturePoint": routeDeparturePoint,
        "routeDestination": routeDestination,
        "timetables": timetables.toJson(),
      };
}

class Timetables {
  Timetables({
    required this.timetableID,
    required this.timetableType,
    required this.timetableOperationStart,
    required this.timetableOperationEnd,
    required this.timetablesByDay,
  });

  int timetableID;
  String timetableType;
  String timetableOperationStart;
  String timetableOperationEnd;
  TimetablesByDay timetablesByDay;

  factory Timetables.fromJson(Map<String, dynamic> json) => Timetables(
        timetableID: json["timetableID"],
        timetableType: json["timetableType"],
        timetableOperationStart: json["timetableOperationStart"],
        timetableOperationEnd: json["timetableOperationEnd"],
        timetablesByDay: TimetablesByDay.fromJson(json["timetablesByDay"]),
      );

  Map<String, dynamic> toJson() => {
        "timetableID": timetableID,
        "timetableType": timetableType,
        "timetableOperationStart": timetableOperationEnd,
        "timetableOperationEnd": timetableOperationEnd,
        "timetablesByDay": timetablesByDay.toJson(),
      };
}

class TimetablesByDay {
  TimetablesByDay({
    required this.day,
    required this.departureTimes,
    required this.arrivalTimes,
  });

  String day;
  String departureTimes;
  String arrivalTimes;

  factory TimetablesByDay.fromJson(Map<String, dynamic> json) =>
      TimetablesByDay(
        day: json["day"],
        departureTimes: json["departureTimes"],
        arrivalTimes: json["arrivalTimes"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "departureTimes": departureTimes,
        "arrivalTimes": arrivalTimes,
      };
}
