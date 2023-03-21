import 'dart:developer';

import 'package:ferry_app/services/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ferry_app/models/ferrytimesmodel.dart';

class FerryTimesApiService {
  GetDay(intOfWeek) {
    String? switchDate;
    switch (intOfWeek) {
      case 1:
        switchDate = "mon";
        debugPrint(switchDate);

        break;
      case 2:
        switchDate = "tue";
        debugPrint(switchDate);

        break;
      case 3:
        switchDate = "wed";
        debugPrint(switchDate);

        break;
      case 4:
        switchDate = "thu";
        debugPrint(switchDate);

        break;
      case 5:
        switchDate = "fri";
        debugPrint(switchDate);

        break;
      case 6:
        switchDate = "sat";
        debugPrint(switchDate);

        break;
      case 7:
        switchDate = "sun";
        debugPrint(switchDate);
        break;
    }
    return switchDate;
  }

  Future<List<FerryTimes>?> getFerryTimes(
      DateTime day, String departurePoint, String arrivalPoint) async {
    int intOfWeek = day.weekday;
    String dayOfWeek = GetDay(intOfWeek);

    String trimDep = departurePoint.replaceAll(' ', '');
    String trimArr = arrivalPoint.replaceAll(' ', '');

    String depID = trimDep.substring(0, 3);
    String arrID = trimArr.substring(0, 3);
    debugPrint("$depID $arrID");

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
