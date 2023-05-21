// ignore_for_file: prefer_final_fields, unnecessary_new

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_application/main.dart';
import 'package:http/http.dart' as http;
import '../base/const.dart' as Constants;
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
    var map = new Map<String, dynamic>();
map['Username'] = username;
map['Password'] = password;
    var res = await http.post(
      Uri.parse(Constants.URl+'/Login/Authenticate'),
      body: jsonEncode(map),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        
      },
    );
    if (res.statusCode == 200) {
      final rs = Map<String, dynamic>.from(json.decode(res.body));
      storage.write(key: "jwt", value: rs['Token']);
 
      Map<String,dynamic> tk=rs['TaiKhoan'];
      User user =
           User.fromJson(tk,username);

          return user;
    } else {
      return null;
    }
  }

  void dispose() {
    _usernameController.close();
    _passwordloginController.close();
  }
}
