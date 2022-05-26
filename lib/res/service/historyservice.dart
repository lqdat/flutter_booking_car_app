import 'dart:convert';
import 'dart:io';
import 'package:flutter_application/res/DTO/history.dart';
import 'package:flutter_application/res/DTO/user.dart';
import 'package:http/http.dart' as http;

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

  static Future<List<History>> postHistory(User user) async {
    String url =
        "https://627b30e4b54fe6ee00839593.mockapi.io/user/${user.userId}/history";
    var res = await http.post(
      Uri.parse(url),
      body: jsonEncode({}),
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
}
