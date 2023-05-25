import 'dart:convert';
import 'dart:io';

import 'package:flutter_application/main.dart';
import 'package:flutter_application/res/DTO/user.dart';
import 'package:http/http.dart' as http;
import '../base/const.dart' as Constants;

class UserService {
  static Future<bool> putUser(
      String name, String email, String phone, String Id) async {
    String url =
        "http://enderg14-001-site1.gtempurl.com/odata/TaiKhoans(guid'${Id}')";

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

  static Future<bool> UploadImage(String id, File file) async {
    Map<String, String> headers = {
      "Accept": "application/json",
    }; // ignore this headers if there is no authentication

    // string to uri
    var uri = Uri.parse(Constants.URl + "QuanLyTaiKhoan/UploadAnh");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file

    // add file to multipart
    request.files.add(await http.MultipartFile.fromPath('picture', file.path));
    //add headers
    request.headers.addAll(headers);

    //adding params
    request.fields['Id'] = id;

    // send
    var response = await request.send();

    print(response.statusCode);
    if (response.statusCode == 204 || response.statusCode == 200) {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
      return true;
    }
    return false;
  }

  static Future<User?> getInfobyId(String id) async {
    String url = Constants.URl + "odata/TaiKhoans(guid'${id}')";
    var res = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (res.statusCode == 204 || res.statusCode == 200) {
      dynamic rs = json.decode(res.body);
      User user = await User.fromJson(rs, '');
      return user;
    } else {
      return null;
    }
  }

  static Future<bool> changePassword(String passOld, String passNew) async {
    String url = Constants.URl +
        "QuanLyTaiKhoan/DoiMatKhau?matKhauCu=${passOld}&matKhauMoi=${passNew}";
    String token = "";
    await storage.read(key: "jwt").then((value) => {
          if (value != null) {token = value}
        });
    var res = await http.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'authorization':'Bearer ${token}'
      },
    );
    if (res.statusCode == 204 || res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
