import 'dart:convert';
import 'dart:io';

import 'package:flutter_application/res/DTO/notification.dart';
import 'package:intl/intl.dart';
import '../base/const.dart'as Contranst;
import '../DTO/user.dart';
import 'package:http/http.dart' as http;
class NotificationService {
  static Future<List<Notify>> getNotify(User user) async {
    String url = Contranst.URl +
        "odata/ThongBaos?\$filter=TaiKhoan_Id eq guid\'" +
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
      List<Notify> notiList =
          rs.map<Notify>((json) => Notify.fromJson(json)).toList();
      return notiList;
    } else {
      return [];
    }
  }
  static Future<Notify?> postNotify(
      User user,
     String title,
     String content) async {
    String url = Contranst.URl + "odata/ThongBaos";
    var res = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "TaiKhoan_Id":user.userId,
        "TieuDe":title,
        "NoiDung":content,
        "Ngay":DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now()),
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 201) {
      var rs = Map<String,dynamic>.from(json.decode(res.body));
      Notify history = Notify.fromJson(rs);
      return history;
    } else {
      return null;
    }
  }
    static Future<bool> deleteNotifybyId(
    String Id,
  ) async {
    String url =
        Contranst.URl+"odata/ThongBaos(guid'" + Id+ "')"  ;;
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
}