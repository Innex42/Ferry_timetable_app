//import 'package:ferry_app/models/routemodel.dart';
//import 'package:ferry_app/services/route_api_service.dart';

import 'package:ferry_app/models/ferrytimesmodel.dart';
import 'package:ferry_app/models/weatherdatamodel.dart';
import 'package:ferry_app/services/ferry_times_api_service.dart';
import 'package:ferry_app/services/weather_api_service.dart';
import 'package:flutter/material.dart';
import 'package:ferry_app/widgets/listitemwidget.dart';
import 'package:recase/recase.dart';

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
  List<FerryTimes>? postSelectedTimeFerryTimes = [];
  late List<WeatherData>? weatherData = [];
  late List<WeatherData>? selectedWeatherData = [];
  List<WeatherData>? postSelectedTimeWeatherData = [];
  bool isAllSelected = false;
  bool postSelectedPopulated = false;

  @override
  void initState() {
    super.initState();
    isAllSelected = false;
    _getData();
  }

  void _getData() async {
    ferryTimes = await FerryTimesApiService().getFerryTimes(
        widget.requestedDate,
        widget.requestedDeparturePoint,
        widget.requestedArrivalPoint);
    weatherData = await WeatherApiService().getWeatherData(widget.requestedDate,
        widget.requestedDeparturePoint, widget.requestedArrivalPoint);
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
    for (var i = 0; i < ferryTimes!.length; i++) {
      if (ferryTimes![i].departureTime.hour > widget.requestedTime.hour) {
        postSelectedTimeFerryTimes!.add(ferryTimes![i]);
        postSelectedTimeWeatherData!.add(selectedWeatherData![i]);
        postSelectedPopulated = true;
      } else if (ferryTimes![i].departureTime.hour ==
              widget.requestedTime.hour &&
          ferryTimes![i].departureTime.minute >= widget.requestedTime.minute) {
        postSelectedTimeFerryTimes!.add(ferryTimes![i]);
        postSelectedTimeWeatherData!.add(selectedWeatherData![i]);
        postSelectedPopulated = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: "${widget.requestedDeparturePoint.titleCase} "),
                WidgetSpan(child: Icon(Icons.arrow_forward)),
                TextSpan(text: " ${widget.requestedArrivalPoint.titleCase}"),
              ],
            ),
          ),
        ),
        body: ferryTimes == null ||
                ferryTimes!.isEmpty && weatherData == null ||
                weatherData!.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  CheckboxListTile(
                    title: Text("Show all Scheduled Sailings"),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: isAllSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        isAllSelected = value!;
                      });
                    },
                  ),
                  if (isAllSelected == false) ...[
                    if (postSelectedPopulated == false) ...[
                      SizedBox(
                        height: 50,
                      ),
                      Icon(
                        Icons.error,
                        size: 200,
                        color: Color(0xffD6D6D6),
                      ),
                      //Text("There are no sailing that depart after your selected time."),
                      Container(
                        width: 350,
                        child: Text(
                          "There are no sailing that depart after your selected time. Please either return to the Search page and enter a new time or select the show all scheduled sailing checkbox to see all the sailing for your selected day.",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),

                      //Text("Please either return to the Search page and enter a new time or select the show all sailing checkbox to see all the sailing for your selected day.")
                      //Text("There are no sailing that depart after your selected time. Please either return to the Search page and enter a new time or select the show all sailing checkbox to see all the sailing for your selected day."),
                    ] else ...[
                      Expanded(
                        child: customListView(
                            context,
                            postSelectedTimeFerryTimes,
                            postSelectedTimeWeatherData),
                      )
                    ]
                  ] else ...[
                    Expanded(
                      child: customListView(
                          context, ferryTimes, selectedWeatherData),
                    )
                  ],
                ],
              ),
      );
}
