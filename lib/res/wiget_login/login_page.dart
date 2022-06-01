// ignore_for_file: unnecessary_new

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/res/DTO/user.dart';
import 'package:flutter_application/res/base/base.dart';
import 'package:flutter_application/res/stream/auth_check.dart';
import 'package:flutter_application/res/wiget_home/home_page.dart';
import 'package:flutter_application/res/wiget_login/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthCheck authCheck = new AuthCheck();
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordloginController =
      new TextEditingController();
  Base base = new Base();
  bool isShow = false;
  bool isLoading = false;
  late User user;

  @override
  void dispose() {
    authCheck.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              SizedBox(
                height: 90,
              ),
              Image.asset('assets/images/logo.png'),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                child: Text("Xin Chào !",
                    style: TextStyle(fontSize: 22, color: Colors.black87)),
              ),
              Text("Đăng nhập để sử dụng ứng dụng ITrans",
                  style: TextStyle(fontSize: 18, color: Colors.black38)),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 70, 0, 20),
                child: StreamBuilder(
                    stream: authCheck.usernameStream,
                    builder: (context, snapshot) => TextField(
                          controller: _usernameController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            labelText: "Tài Khoản",
                            prefixIcon: SizedBox(
                              width: 50,
                              child:
                                  Image.asset('assets/images/ic_username.png'),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                          ),
                        )),
              ),
              Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  StreamBuilder(
                    stream: authCheck.passwordloginStream,
                    builder: (context, snapshot) => TextField(
                      controller: _passwordloginController,
                      obscureText: !isShow,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        errorText: snapshot.hasError
                            ? snapshot.error.toString()
                            : null,
                        labelText: "Mật khẩu",
                        prefixIcon: SizedBox(
                          width: 50,
                          child: Image.asset('assets/images/ic_password.png'),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
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
                ],
              ),
              Container(
                  alignment: AlignmentDirectional.centerEnd,
                  constraints:
                      BoxConstraints.loose((Size(double.infinity, 50))),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text("Quên mật khẩu ?",
                          style: TextStyle(
                              fontSize: 18, color: Colors.blueAccent[300])))),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
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
                            : Icon(Icons.login_rounded, color: Colors.white),
                        onPressed: () {
                          login();
                        },
                        label: Text(!isLoading ? "Đăng nhập" : "",
                            style:
                                TextStyle(fontSize: 25, color: Colors.white)),
                      ))),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: RichText(
                    text: TextSpan(
                      text: "Chưa có tài khoản? ",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                          text: "Đăng ký ",
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 18),
                        )
                      ],
                    ),
                  ))
            ],
          ))),
    );
  }

  void login() {
    var isValid = authCheck.isValid(
        _usernameController.text, _passwordloginController.text);
    if (isValid) {
      setState(() {
        isLoading = true;
      });
      Future<Object?> check = authCheck.signIn(
          _usernameController.text, _passwordloginController.text);
      check.then((value) => {
            if (value != null)
              {
                setState(() {
                  isLoading = false;
                  user = value as User;
                }),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage(user))),
                base.showToastSucces(context, "Đăng nhập thành công !")
              }
            else
              {
                setState(() {
                  isLoading = false;
                }),
                base.showToastError(context, "Đăng nhập thất bại !")
              }
          });
    }
  }
}
