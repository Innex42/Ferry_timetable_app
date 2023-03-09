//import 'package:ferry_app/models/routemodel.dart';
//import 'package:ferry_app/services/route_api_service.dart';

import 'package:ferry_app/models/ferrytimesmodel.dart';
import 'package:ferry_app/models/weatherdatamodel.dart';
import 'package:ferry_app/services/ferry_times_api_service.dart';
import 'package:ferry_app/services/weather_api_service.dart';
import 'package:flutter/material.dart';
import 'package:ferry_app/widgets/listitemwidget.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late List<FerryTimes>? ferryTimes = [];
  late List<WeatherData>? weatherData = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    ferryTimes = await FerryTimesApiService().getFerryTimes();
    weatherData = await WeatherApiService().getWeatherData();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
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
            : customListView(context, ferryTimes),
      );
}
