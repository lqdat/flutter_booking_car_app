import 'package:flutter/material.dart';
import 'package:flutter_application/res/wiget_login/login_page.dart';

class MyApp extends StatefulWidget {
  @override
  // ignore: override_on_non_overriding_member
  _MyApp createState() => _MyApp();
}

@override
class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
