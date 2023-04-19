import 'dart:developer';

import 'package:ferry_app/services/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ferry_app/models/ferrytimesmodel.dart';

class FerryTimesApiService {
  //Switch case to find the day in the week the requested date is on
  GetDay(intOfWeek) {
    String? switchDate;
    switch (intOfWeek) {
      case 1:
        //Monday
        switchDate = "mon";
        debugPrint(switchDate);

        break;
      case 2:
        // Tuesday
        switchDate = "tue";
        debugPrint(switchDate);

        break;
      case 3:
        //Wednesday
        switchDate = "wed";
        debugPrint(switchDate);

        break;
      case 4:
        //Thursday
        switchDate = "thu";
        debugPrint(switchDate);

        break;
      case 5:
        //Friday
        switchDate = "fri";
        debugPrint(switchDate);

        break;
      case 6:
        //Saturday
        switchDate = "sat";
        debugPrint(switchDate);

        break;
      case 7:
        //Sunday
        switchDate = "sun";
        debugPrint(switchDate);
        break;
    }
    return switchDate;
  }

  Future<List<FerryTimes>?> getFerryTimes(
      DateTime day, String departurePoint, String arrivalPoint) async {
    //get day in the week
    int intOfWeek = day.weekday;
    String dayOfWeek = GetDay(intOfWeek);

    //removes the spaces from requested locations
    String trimDep = departurePoint.replaceAll(' ', '');
    String trimArr = arrivalPoint.replaceAll(' ', '');

    //trims locations to 3 letters for route id
    String depID = trimDep.substring(0, 3);
    String arrID = trimArr.substring(0, 3);
    debugPrint("$depID $arrID");

    //http request with formatted parameters (departure point, arrival point, day of travel)
    try {
      var url = Uri.parse(
          "${ApiConstants.ferryTimesApiUrlStart}/$depID-$arrID/$dayOfWeek");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<FerryTimes> _model = ferryTimesFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
