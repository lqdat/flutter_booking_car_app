import 'package:flutter/material.dart';
import 'package:flutter_application/res/base/base.dart';
import 'package:flutter_application/res/service/userservice.dart';

import '../DTO/user.dart';
import '../stream/changepass_bloc.dart';

// ignore: must_be_immutable
class ChangePass extends StatefulWidget {
  User user;
  ChangePass(this.user);
  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  Base base = new Base();
  ChangePassStream changePass_bloc = new ChangePassStream();
  TextEditingController passNew = new TextEditingController();
  TextEditingController passOld = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
               ),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: const [
                  Color.fromARGB(136, 6, 54, 113),
                  Color.fromARGB(255, 135, 164, 206)
                ])),
        child: Column(
          children: <Widget>[
            Stack(children: [
              SizedBox(
                width: double.infinity,
                height: 56.0,
                child: Center(
                    child: Text("Đổi mật khẩu",
                        style: TextStyle(fontSize: 22, color: Colors.black))),
              ),
              Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: IconButton(
                      icon: Image.asset("assets/images/ic_remove.png"),
                      iconSize: 40,
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      }))
            ]),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 4),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme:
                      ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
                  hintColor: Colors.white,
                ), // set color here
                child: StreamBuilder(
                  stream: changePass_bloc.passOldStream,
                  builder: (context, snap) => TextField(
                    controller: passOld,
                    cursorColor: Colors.white,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      labelText: "Mật khẩu cũ",
                      floatingLabelStyle: TextStyle(color: Colors.white),
                      prefixIcon: SizedBox(
                          height: 70,
                          width: 50,
                          child: Icon(
                            Icons.key_outlined,
                            color: Colors.white,
                          )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 4),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme:
                      ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
                  hintColor: Colors.white,
                ), // set color here
                child: StreamBuilder(
                  stream: changePass_bloc.passNewStream,
                  builder: (context, snap) => TextField(
                    controller: passNew,
                    cursorColor: Colors.white,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      labelText: "Mật khẩu mới",
                      floatingLabelStyle: TextStyle(color: Colors.white),
                      prefixIcon: SizedBox(
                          height: 70,
                          width: 50,
                          child: Icon(
                            Icons.key_outlined,
                            color: Colors.white,
                          )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 70,
                      width: 200,
                      child: Align(
                          child: ElevatedButton(
                        onPressed: () {
                          changePass();
                        },
                        child: Text(
                          "Lưu",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                              ),
                            ),
                            minimumSize: Size(200, 70),
                            shadowColor: Colors.transparent),
                      )),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> changePass() async {
    await UserService.changePassword(passOld.text, passNew.text)
        .then((value) => {
              if (value)
                {
                  base.showToastSucces(context, "Đổi mật khẩu thành công !"),
                  Navigator.pop(context)
                }
              else
                {
                  base.showToastSucces(
                      context, "Đổi mật khẩu không thành công !")
                }
            });
  }
}
