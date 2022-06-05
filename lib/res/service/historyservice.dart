import 'dart:convert';
import 'dart:io';
import 'package:flutter_application/res/DTO/history.dart';
import 'package:flutter_application/res/DTO/user.dart';
import 'package:http/http.dart' as http;
import 'package:tiengviet/tiengviet.dart';

class HistoryService {
  static Future<List<History>> getHistory(User user) async {
    String url =
        "https://627b30e4b54fe6ee00839593.mockapi.io/user/${user.userId}/history";
    var res = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 200) {
      List<dynamic> rs = json.decode(res.body).cast<Map<String, dynamic>>();
      List<History> historyList =
          rs.map<History>((json) => History.fromJson(json)).toList();
      return historyList;
    } else {
      return [];
    }
  }

  static Future<History?> postHistory(
      User user,
      String form_add,
      String to_add,
      DateTime datetime,
      double cast,
      int rating,
      int distance,
      String text,
      String carId,
      bool status) async {
    String url =
        "https://627b30e4b54fe6ee00839593.mockapi.io/user/${user.userId}/history";
    var res = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "createdAt": DateTime.now().toString(),
        "from_address": TiengViet.parse(form_add),
        "to_address": TiengViet.parse(to_add),
        "price": cast,
        "date": datetime.toString(),
        "distance": distance,
        "rating": rating,
        "text": text,
        "id": DateTime.now().millisecond.toString(),
        "carId": carId.toString(),
        "status": status,
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 201) {
      dynamic rs = json.decode(res.body);
      History history = History.fromJson(rs);
      return history;
    } else {
      return null;
    }
  }

  static Future<bool> putHistory(
      User user,
      String form_add,
      String to_add,
      DateTime datetime,
      double cast,
      int rating,
      int distance,
      String text,
      int carId,
      String historyId,
      bool status) async {
    String url =
        "https://627b30e4b54fe6ee00839593.mockapi.io/user/${user.userId}/history/${historyId}";
    var res = await http.put(
      Uri.parse(url),
      body: jsonEncode({
        "createdAt": DateTime.now().toString(),
        "from_address": TiengViet.parse(form_add),
        "to_address": TiengViet.parse(to_add),
        "price": cast,
        "date": datetime.toString(),
        "distance": distance,
        "rating": rating,
        "text": text,
        "id": DateTime.now().millisecond.toString(),
        "status": status,
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 201 || res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteHistory(
    User user,
    String param,
  ) async {
    String url =
        "https://627b30e4b54fe6ee00839593.mockapi.io/user/${user.userId}/history/${param}";
    var res = await http.delete(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 201 || res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<History?> getHistorybyId(User user, String Id) async {
    String url =
        "https://627b30e4b54fe6ee00839593.mockapi.io/user/${user.userId}/history/${Id}";
    var res = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 200) {
      dynamic rs = json.decode(res.body);
      History historyList = History.fromJson(rs);
      return historyList;
    } else {
      return null;
    }
  }
}
