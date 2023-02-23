import 'dart:convert';
import 'package:ferry_app/services/constants.dart';
import 'package:http/http.dart' as http;
import 'package:ferry_app/models/routemodel.dart';

class RouteApiService {
  Future<RouteModel> getRoute() async {
    var client = http.Client();
    var uri = Uri.parse('http://10.0.2.2:3001/routes/test');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return routeModelFromJson(response.body);
    } else {
      throw Exception('Failed to load Route');
    }
  }
}
