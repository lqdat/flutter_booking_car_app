import 'dart:convert';
import 'dart:io';

import 'package:flutter_application/res/DTO/user.dart';
import 'package:http/http.dart' as http;
import '../base/const.dart' as Constants;
class UserService {
  static Future<bool> putUser( String name, String email,
      String phone,String Id) async {
    String url = "http://enderg14-001-site1.gtempurl.com/odata/TaiKhoans(guid'${Id}')";

    var res = await http.patch(
      Uri.parse(url),
      body: jsonEncode({
        "TenHienThi": name,
        "SDT": phone,
        "Email": email,
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 204 || res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<User?> getInfobyId(String id) async {
    String url = Constants.URl+"/odata/TaiKhoans(guid'${id}')";
    var res = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (res.statusCode == 204 || res.statusCode == 200) {
      dynamic rs = json.decode(res.body);
       User user = await User.fromJson(rs,'');
      return user;
    } else {
      return null;
    }
  }
}
