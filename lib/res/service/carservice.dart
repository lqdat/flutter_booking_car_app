import 'dart:convert';
import 'dart:io';

import 'package:flutter_application/res/DTO/car.dart';
import 'package:http/http.dart' as http;

class CarService {
  static Future<List<Car>> getCar() async {
    String url = "https://627b30e4b54fe6ee00839593.mockapi.io/car";
    var res = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 200) {
      List<dynamic> rs = json.decode(res.body).cast<Map<String, dynamic>>();
      List<Car> carList = rs.map<Car>((json) => Car.fromJson(json)).toList();
      return carList;
    } else {
      return [];
    }
  }
}
