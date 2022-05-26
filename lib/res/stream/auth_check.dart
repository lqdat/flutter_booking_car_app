// ignore_for_file: prefer_final_fields, unnecessary_new

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_application/main.dart';
import 'package:http/http.dart' as http;

import '../DTO/user.dart';

class AuthCheck {
  StreamController _usernameController = new StreamController();
  StreamController _passwordloginController = new StreamController();

  Stream get usernameStream => _usernameController.stream;
  Stream get passwordloginStream => _passwordloginController.stream;

  bool isValid(String username, String password) {
    if (username.isEmpty) {
      _usernameController.sink.addError("Vui lòng nhập tên");
      return false;
    }
    _usernameController.sink.add("");
    if (password.isEmpty || password.length < 5) {
      _passwordloginController.sink
          .addError("Mật khẩu phải có it nhất 6 ký tự");
      return false;
    }
    _passwordloginController.sink.add("");

    return true;
  }

  Future<Object?> signIn(String username, String password) async {
    User? user;
    var res = await http.get(
      Uri.parse('https://627b30e4b54fe6ee00839593.mockapi.io/user'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (res.body.isNotEmpty) {
      final rs = json.decode(res.body).cast<Map<String, dynamic>>();
      List<User> userList =
          rs.map<User>((json) => User.fromJson(json)).toList();
      for (var i = 0; i < userList.length; i++) {
        if (username == userList[i].username &&
            password == userList[i].password) {
          storage.write(key: "jwt", value: userList[i].password);
          user = new User(
              userId: userList[i].userId,
              username: userList[i].username,
              email: userList[i].email,
              password: userList[i].password,
              phone: userList[i].phone);
          return user;
        }
      }
      return null;
    } else {
      return null;
    }
  }

  void dispose() {
    _usernameController.close();
    _passwordloginController.close();
  }
}
