import 'dart:convert';
import 'dart:io';

import 'package:flutter_application/res/DTO/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<bool> putUser(String id, String name, String email,
      String phone, String password, String username) async {
    String url = "https://627b30e4b54fe6ee00839593.mockapi.io/user/${id}";
    var res = await http.put(
      Uri.parse(url),
      body: jsonEncode({
        "createdAt": DateTime.now().toString(),
        "username": username,
        "name": name,
        "sdt": phone,
        "email": email,
        "password": password,
        "id": id
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

  static Future<User?> getInfobyId(String id) async {
    String url = "https://627b30e4b54fe6ee00839593.mockapi.io/user/${id}";
    var res = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (res.statusCode == 201 || res.statusCode == 200) {
      dynamic rs = json.decode(res.body);
      User user = User.fromJson(rs);
      return user;
    } else {
      return null;
    }
  }
}
