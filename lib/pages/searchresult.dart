//import 'package:ferry_app/models/routemodel.dart';
//import 'package:ferry_app/services/route_api_service.dart';

import 'package:ferry_app/models/ferrytimesmodel.dart';
import 'package:ferry_app/models/weatherdatamodel.dart';
import 'package:ferry_app/services/ferry_times_api_service.dart';
import 'package:ferry_app/services/weather_api_service.dart';
import 'package:flutter/material.dart';
import 'package:ferry_app/widgets/listitemwidget.dart';

class SearchResultPage extends StatefulWidget {
  final DateTime requestedDate;
  final String requestedDeparturePoint;
  final String requestedArrivalPoint;
  final TimeOfDay requestedTime;

  const SearchResultPage({
    super.key,
    required this.requestedDate,
    required this.requestedDeparturePoint,
    required this.requestedArrivalPoint,
    required this.requestedTime,
  });

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late List<FerryTimes>? ferryTimes = [];
  late List<WeatherData>? weatherData = [];
  late List<WeatherData>? selectedWeatherData = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    ferryTimes = await FerryTimesApiService().getFerryTimes(
        widget.requestedDate,
        widget.requestedDeparturePoint,
        widget.requestedArrivalPoint);
    weatherData = await WeatherApiService().getWeatherData();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    for (var i = 0; i < ferryTimes!.length; i++) {
      int weatherIndex;
      if (ferryTimes![i].departureTime.minute > 30) {
        weatherIndex = weatherData!.indexWhere((element) =>
            element.datetime.hour == ferryTimes![i].departureTime.hour + 1);
        selectedWeatherData!.add(weatherData![weatherIndex]);
      } else {
        weatherIndex = weatherData!.indexWhere((element) =>
            element.datetime.hour == ferryTimes![i].departureTime.hour);
        selectedWeatherData!.add(weatherData![weatherIndex]);
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Search result'),
        ),
        body: ferryTimes == null ||
                ferryTimes!.isEmpty && weatherData == null ||
                weatherData!.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : customListView(context, ferryTimes, selectedWeatherData),
      );
}
