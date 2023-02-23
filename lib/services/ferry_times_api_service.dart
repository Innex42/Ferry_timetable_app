import 'dart:developer';

import 'package:ferry_app/services/constants.dart';
import 'package:http/http.dart' as http;
import 'package:ferry_app/models/ferrytimesmodel.dart';

class FerryTimesApiService {
  Future<List<FerryTimes>?> getFerryTimes() async {
    try {
      var url = Uri.parse('http://192.168.1.186:3001/gilltest');
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
