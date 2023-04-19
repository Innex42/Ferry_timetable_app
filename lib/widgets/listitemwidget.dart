import 'package:flutter/material.dart';
import 'package:ferry_app/models/ferrytimesmodel.dart';
import 'package:ferry_app/models/weatherdatamodel.dart';

Widget customListView(BuildContext context, List<FerryTimes>? ferryTimes,
    List<WeatherData>? selectedWeatherData) {
  //List iconsTest = [9, 35, 46];
  List highWindValue = [];
  //compares the wind speed and wind gust values to find the highest value
  for (var i = 0; i < selectedWeatherData!.length; i++) {
    if (double.parse(selectedWeatherData[i].windgust) >
        double.parse(selectedWeatherData[i].windspeed)) {
      highWindValue.add(double.parse(selectedWeatherData[i].windgust));
    } else if (double.parse(selectedWeatherData[i].windspeed) >
        double.parse(selectedWeatherData[i].windgust)) {
      highWindValue.add(double.parse(selectedWeatherData[i].windspeed));
    } else {
      highWindValue.add(double.parse(selectedWeatherData[i].windgust));
    }
  }
  return ListView.builder(
      itemCount: ferryTimes!.length,
      itemBuilder: (context, index) {
        //custom Listview Item
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
                    //Departure Time
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
                    //Arrival Time
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
                  //Weather Risk Icons
                  children: [
                    //Green for when wind is below 30 mph
                    if (highWindValue[index] < 30) ...[
                      Tooltip(
                        message:
                            "The likelihood of weather related disruptions is low.",
                        triggerMode: TooltipTriggerMode.tap,
                        showDuration: const Duration(seconds: 5),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 50,
                        ),
                      )
                    ],
                    //Amber for when the wind is between 30 and 45 mph
                    if (highWindValue[index] >= 30 &&
                        highWindValue[index] < 46) ...[
                      Tooltip(
                        message:
                            "There is a heightened risk of disruption to this service due to Average Wind Speeds of ${selectedWeatherData[index].windspeed}mph or Gusts of ${selectedWeatherData[index].windgust}mph",
                        triggerMode: TooltipTriggerMode.tap,
                        showDuration: const Duration(seconds: 5),
                        child: Icon(
                          Icons.error,
                          color: Colors.orange,
                          size: 50,
                        ),
                      )
                    ],
                    // Red for when the Wind exceeds 46 mph
                    if (highWindValue[index] >= 46) ...[
                      Tooltip(
                        message:
                            "There is a strong likelihood of disruption or cancellations to this service due to Average Wind Speeds of ${selectedWeatherData[index].windspeed}mph and Gusts of ${selectedWeatherData[index].windgust}mph",
                        triggerMode: TooltipTriggerMode.tap,
                        showDuration: const Duration(seconds: 5),
                        child: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 50,
                        ),
                      )
                    ],
                    SizedBox(
                      width: 10,
                    ),
                    //Guide to tell user how to get more detail on weather that is affecting the sailing
                    Text(
                      """Tap Icon for more Information""",
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    //Sailing Duration
                    Tooltip(
                      message: "Sailing Duration",
                      triggerMode: TooltipTriggerMode.tap,
                      showDuration: const Duration(seconds: 5),
                      child: Text(ferryTimes[index].duration,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
