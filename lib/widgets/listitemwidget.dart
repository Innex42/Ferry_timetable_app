import 'package:flutter/material.dart';
import 'package:ferry_app/models/ferrytimesmodel.dart';
import 'package:ferry_app/models/weatherdatamodel.dart';

Widget customListView(BuildContext context, List<FerryTimes>? ferryTimes,
    List<WeatherData>? selectedWeatherData) {
  //List iconsTest = [9, 35, 46];
  return ListView.builder(
      itemCount: ferryTimes!.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.lightBlueAccent),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    if (ferryTimes[index].departureTime.minute > 9 &&
                        ferryTimes[index].departureTime.hour > 9) ...[
                      Text(
                        "${ferryTimes[index].departureTime.hour}:${ferryTimes[index].departureTime.minute}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      )
                    ],
                    if (ferryTimes[index].departureTime.minute <= 9 &&
                        ferryTimes[index].departureTime.hour > 9) ...[
                      Text(
                        "${ferryTimes[index].departureTime.hour}:0${ferryTimes[index].departureTime.minute}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      )
                    ],
                    if (ferryTimes[index].departureTime.minute > 9 &&
                        ferryTimes[index].departureTime.hour <= 9) ...[
                      Text(
                        "0${ferryTimes[index].departureTime.hour}:${ferryTimes[index].departureTime.minute}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      )
                    ],
                    if (ferryTimes[index].departureTime.minute <= 9 &&
                        ferryTimes[index].departureTime.hour <= 9) ...[
                      Text(
                        "0${ferryTimes[index].departureTime.hour}:0${ferryTimes[index].departureTime.minute}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      )
                    ],
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (ferryTimes[index].arrivalTime.minute > 9 &&
                        ferryTimes[index].arrivalTime.hour > 9) ...[
                      Text(
                        "${ferryTimes[index].arrivalTime.hour}:${ferryTimes[index].arrivalTime.minute}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      )
                    ],
                    if (ferryTimes[index].arrivalTime.minute <= 9 &&
                        ferryTimes[index].arrivalTime.hour <= 9) ...[
                      Text(
                        "0${ferryTimes[index].arrivalTime.hour}:0${ferryTimes[index].arrivalTime.minute}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      )
                    ],
                    if (ferryTimes[index].arrivalTime.minute <= 9 &&
                        ferryTimes[index].arrivalTime.hour > 9) ...[
                      Text(
                        "0${ferryTimes[index].arrivalTime.hour}:${ferryTimes[index].arrivalTime.minute}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      )
                    ],
                    if (ferryTimes[index].arrivalTime.minute > 9 &&
                        ferryTimes[index].arrivalTime.hour <= 9) ...[
                      Text(
                        "0${ferryTimes[index].arrivalTime.hour}:${ferryTimes[index].arrivalTime.minute}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      )
                    ]
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    if (double.parse(selectedWeatherData![index].windgust) <
                            30 ||
                        double.parse(selectedWeatherData[index].windspeed) <
                            30) ...[
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 50,
                      )
                    ],
                    if (double.parse(selectedWeatherData[index].windgust) >=
                                30 &&
                            double.parse(selectedWeatherData[index].windgust) <
                                46 ||
                        double.parse(selectedWeatherData[index].windspeed) >=
                                30 &&
                            double.parse(selectedWeatherData[index].windspeed) <
                                46) ...[
                      Icon(
                        Icons.error,
                        color: Colors.orange,
                        size: 50,
                      )
                    ],
                    if (double.parse(selectedWeatherData[index].windgust) >=
                            46 ||
                        double.parse(selectedWeatherData[index].windspeed) >=
                            46) ...[
                      Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 50,
                      )
                    ],
                    SizedBox(
                      width: 30,
                    ),
                    Text(ferryTimes[index].duration,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20))
                  ],
                )
              ],
            ),
          ),
        );
      });
}
