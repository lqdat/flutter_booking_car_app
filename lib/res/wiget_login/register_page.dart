// ignore_for_file: unnecessary_new, prefer_final_fields

import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/res/base/base.dart';
import 'package:flutter_application/res/stream/auth_vali.dart';
import 'package:flutter_application/res/wiget_login/login_page.dart';

import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  AuthValid authVali = new AuthValid();
  Base base = new Base();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  bool isShow = false;
  bool isLoading = false;
  @override
  void dispose() {
    authVali.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blueAccent, size: 40),
        elevation: 0,
        // title: Text(
        //   "Quay lại",
        //   style: TextStyle(color: Colors.blueAccent, fontSize: 18),
        // )
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              // SizedBox(
              //   height: 50,
              // ),
              Image.asset('assets/images/logo.png'),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                child: Text("Đăng ký tài khoản mới",
                    style: TextStyle(fontSize: 22, color: Colors.black87)),
              ),
              Text("Đăng ký để tham gia cùng ITrans ",
                  style: TextStyle(fontSize: 18, color: Colors.black38)),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                child: StreamBuilder(
                  stream: authVali.nameStream,
                  builder: (context, snapshot) => TextField(
                    controller: _nameController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      labelText: "Tài Khoản",
                      prefixIcon: SizedBox(
                        width: 50,
                        child: Image.asset('assets/images/ic_username.png'),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                  stream: authVali.passwordStream,
                  builder: (context, snapshot) => Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: <Widget>[
                            TextField(
                              obscureText: !isShow,
                              controller: _passwordController,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                errorText: snapshot.hasError
                                    ? snapshot.error.toString()
                                    : null,
                                labelText: "Mật khẩu",
                                prefixIcon: SizedBox(
                                  width: 50,
                                  child: Image.asset(
                                      'assets/images/ic_password.png'),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_red_eye_sharp),
                              color: Color.fromARGB(255, 42, 76, 228),
                              onPressed: () {
                                setState(() => isShow = !isShow);
                              },
                            ),
                          ])),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: StreamBuilder(
                  stream: authVali.phoneStream,
                  builder: (context, snapshot) => TextField(
                    controller: _phoneController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      labelText: "Số điện thoại",
                      prefixIcon: SizedBox(
                        width: 50,
                        child: Image.asset('assets/images/ic_phone.png'),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                  stream: authVali.emailStream,
                  builder: (context, snapshot) => TextField(
                    controller: _emailController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      labelText: "Email",
                      prefixIcon: SizedBox(
                        width: 50,
                        child: Image.asset('assets/images/ic_mail.png'),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(6, 54, 113, 1)),
                          shadowColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(6, 54, 113, 1)),
                        ),
                        icon: isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Icon(Icons.person_add_alt),
                        onPressed: () {
                          _onSignUpPress();
                        },
                        label: Text("Đăng ký",
                            style:
                                TextStyle(fontSize: 25, color: Colors.white)),
                      ))),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: RichText(
                    text: TextSpan(
                        text: "Đã có tài khoản? ",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                },
                              text: "Đăng nhập ngay",
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 18))
                        ]),
                  ))
            ],
          ))),
    );
  }

  void fetchPostUser(
      String username, String password, String email, String phone) async {
    setState(() {
      isLoading = true;
    });
    final res = await http.post(
      Uri.parse('https://627b30e4b54fe6ee00839593.mockapi.io/user'),
      body: jsonEncode({
        "createdAt": DateTime.now().toString(),
        "username": username,
        "sdt": phone,
        "email": email,
        "password": password,
        "id": DateTime.now().millisecond.toString()
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 201 || res.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      base.showToastSucces(context, 'Đăng ký thành công !');
    } else {
      throw new Exception('Không thể lấy dữ liệu');
    }
  }

  _onSignUpPress() {
    var isValid = authVali.isValid(_nameController.text,
        _passwordController.text, _phoneController.text, _emailController.text);
    if (isValid) {
      fetchPostUser(_nameController.text, _passwordController.text,
          _emailController.text, _phoneController.text);
    }
  }
}
