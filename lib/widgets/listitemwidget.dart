import 'package:flutter/material.dart';
import 'package:ferry_app/models/ferrytimesmodel.dart';

Widget customListView(BuildContext context, List<FerryTimes>? ferryTimes) {
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
                    Text(
                      "${ferryTimes[index].departureTime.hour}:${ferryTimes[index].departureTime.minute}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
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
                    Text(
                      "${ferryTimes[index].arrivalTime.hour}:${ferryTimes[index].arrivalTime.minute}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.orange,
                      size: 50,
                    ),
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
