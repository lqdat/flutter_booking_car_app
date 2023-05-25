import 'dart:convert';
import 'dart:io';

import 'package:flutter_application/res/DTO/car.dart';
import 'package:http/http.dart' as http;
import '../base/const.dart' as Contranst;
class CarService {
  static Future<List<Car>> getCar() async {
    String url = Contranst.URl + "odata/DM_Xe";
    var res = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 200||res.statusCode ==201) {
      List<dynamic> rs = Map<String, dynamic>.from(json.decode(res.body))['value'];
      List<Car> carList = rs.map<Car>((json) => Car.fromJson(json)).toList();
      return carList;
    } else {
      return [];
    }
  }
  static Future<Car?> getCarbyId(String Id) async {
    String url = Contranst.URl + "odata/DM_Xe(guid'${Id}')";
    var res = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 200||res.statusCode ==201) {
      dynamic rs = Map<String, dynamic>.from(json.decode(res.body));
       var car=Car.fromJson(rs);
      return car;
    } else {
      return null;
    }
  }
}
