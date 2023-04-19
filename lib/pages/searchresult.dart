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
    // Variables passed in from Search Page
    required this.requestedDate,
    required this.requestedDeparturePoint,
    required this.requestedArrivalPoint,
    required this.requestedTime,
  });

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  //List that will hold timetable and weather data at different stages
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
    //makes API calls when page is loaded
    _getData();
  }

  //API calls method
  void _getData() async {
    //get the ferry timetable for the route requested on the requested day from API
    ferryTimes = await FerryTimesApiService().getFerryTimes(
        widget.requestedDate,
        widget.requestedDeparturePoint,
        widget.requestedArrivalPoint);
    //get the weather data for departure and arrival points on requested day from API
    weatherData = await WeatherApiService().getWeatherData(widget.requestedDate,
        widget.requestedDeparturePoint, widget.requestedArrivalPoint);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    //creates weather list that is the same size as the timetables list using the times of the sailings
    for (var i = 0; i < ferryTimes!.length; i++) {
      int weatherIndex;
      //if time is closer to next hour use the weather data for the next hour (i.e 3:45 is closer to 4 than 3)
      if (ferryTimes![i].departureTime.minute > 30) {
        weatherIndex = weatherData!.indexWhere((element) =>
            element.datetime.hour == ferryTimes![i].departureTime.hour + 1);
        selectedWeatherData!.add(weatherData![weatherIndex]);
      }
      //when time is under half past use the weather for that hour
      else {
        weatherIndex = weatherData!.indexWhere((element) =>
            element.datetime.hour == ferryTimes![i].departureTime.hour);
        selectedWeatherData!.add(weatherData![weatherIndex]);
      }
    }
    //Get the Sailings that are after the requested time
    for (var i = 0; i < ferryTimes!.length; i++) {
      //add sailing if hour is after the requested time's hour
      if (ferryTimes![i].departureTime.hour > widget.requestedTime.hour) {
        postSelectedTimeFerryTimes!.add(ferryTimes![i]);
        postSelectedTimeWeatherData!.add(selectedWeatherData![i]);
        postSelectedPopulated = true;
      }
      //for if requested times hours is the same as a sailing departure time, check if minute is past requested time's minute
      else if (ferryTimes![i].departureTime.hour == widget.requestedTime.hour &&
          ferryTimes![i].departureTime.minute >= widget.requestedTime.minute) {
        postSelectedTimeFerryTimes!.add(ferryTimes![i]);
        postSelectedTimeWeatherData!.add(selectedWeatherData![i]);
        postSelectedPopulated = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        //AppBar shows the departure and arrival points
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
        // API request is still loading show Loading Spinner
        body: ferryTimes == null ||
                ferryTimes!.isEmpty && weatherData == null ||
                weatherData!.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            :
            //Shown when API Calls are completed
            Column(
                children: [
                  //CheckBox to select between sailings post requested time list or the full list of sailings
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
                  //Error Message is displayed if there is no sailings after requested time
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
                    ] else ...[
                      //Listview widget for displaying the ferry times post selected time
                      Expanded(
                        child: customListView(
                            context,
                            postSelectedTimeFerryTimes,
                            postSelectedTimeWeatherData),
                      )
                    ]
                  ] else ...[
                    //Listview widget for displaying all ferry times when the checkbox is ticked
                    Expanded(
                      child: customListView(
                          context, ferryTimes, selectedWeatherData),
                    )
                  ],
                ],
              ),
      );
}
