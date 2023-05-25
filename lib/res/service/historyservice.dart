import 'dart:convert';
import 'dart:io';
import 'package:flutter_application/res/DTO/history.dart';
import 'package:flutter_application/res/DTO/user.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:uuid/uuid.dart';
import '../base/const.dart' as Contranst;

class HistoryService {
  static Future<List<History>> getHistory(User user) async {
    String url = Contranst.URl +
        "odata/BookHistories?\$filter=TaiKhoan_Id eq guid\'" +
        user.userId +
        "\'";

    var res = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 200) {
      List<dynamic> rs =
          Map<String, dynamic>.from(json.decode(res.body))['value'];
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
      double? cast,
      int rating,
      int distance,
      String text,
      String carId,
      bool status,
      String? idVoucher) async {
    String url = Contranst.URl + "odata/BookHistories";
    var res = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "DiaDiemDi": TiengViet.parse(form_add),
        "DiaDiemDen": TiengViet.parse(to_add),
        "GiaTien": cast.toString(),
        "NgayDat": DateFormat('yyyy-MM-ddTHH:mm:ss').format(datetime),
        "KhoangCach": distance,
        "Sao":0,
        "DanhGia": "",
        "Xe_Id": carId,
        "TaiKhoan_Id": user.userId,
        "TrangThai": status?1:0,
        "GiamGia_Id":idVoucher??null,
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 201) {
      var rs = Map<String,dynamic>.from(json.decode(res.body));

      History history = History.fromJson(rs);
      return history;
    } else {
      return null;
    }
  }

  static Future<bool> putHistory(
      int rating,
      String text,
      String historyId,
      bool status) async {
    String url =
        Contranst.URl+"odata/BookHistories(guid'" + historyId+ "')"  ;
    var res = await http.patch(
      Uri.parse(url),
      body: jsonEncode({
        "Sao": rating,
        "DanhGia": text.toString(),
        "TrangThai": status?1:0,
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 200 || res.statusCode == 204) {
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
        Contranst.URl+"odata/BookHistories(guid'" + param+ "')"  ;;
    var res = await http.delete(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 201 || res.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteHistorybyId(
    String Id,
  ) async {
    String url =
        Contranst.URl+"odata/BookHistories(guid'" + Id+ "')"  ;;
    var res = await http.delete(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 201 || res.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  static Future<History?> getHistorybyId(User user, String Id) async {
    String url =
       Contranst.URl+"odata/BookHistories?\$filter=Id eq guid\'" +
        Id +
        "\'" +
        '&\$expand=DM_Xe';

    var res = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 200) {
      var rs = Map<String,dynamic>.from( json.decode(res.body))['value'][0];
      History historyList = History.fromJson(rs);
      return historyList;
    } else {
      return null;
    }
  }
}
