// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application/res/DTO/user.dart';
import 'package:flutter_application/res/wiget_history/wiget_history.dart';
import 'package:flutter_application/res/wiget_login/login_page.dart';
import 'package:flutter_application/res/wiget_profile/wiget_profile.dart';

class MenuWiget extends StatefulWidget {
  User user;
  MenuWiget(this.user);
  @override
  _MenuWiget createState() => _MenuWiget();
}

class _MenuWiget extends State<MenuWiget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Image.asset('assets/images/logo.png', width: 150, height: 150),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(widget.user)));
          },
          child: ListTile(
            leading: Image.asset(
              "assets/images/ic_profile.png",
            ),
            title: Text("Thông tin cá nhân",
                style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HistoryPage(widget.user)));
          },
          child: ListTile(
            leading: Image.asset("assets/images/ic_history.png"),
            title: Text("Lịch sử đặt xe",
                style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: ListTile(
            leading: Image.asset("assets/images/ic_notification.png"),
            title: Text("Thông báo",
                style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: ListTile(
            leading: Image.asset("assets/images/ic_discount.png"),
            title: Text("Voucher",
                style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: ListTile(
            leading: Image.asset("assets/images/ic_help.png"),
            title: Text("Trợ giúp",
                style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          child: ListTile(
            leading: Image.asset("assets/images/ic_logout.png"),
            title: Text("Đăng xuất",
                style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          ),
        )
      ],
    );
  }
}
