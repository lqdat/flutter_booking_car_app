// ignore_for_file: unused_field, unnecessary_new, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application/res/DTO/user.dart';
import 'package:flutter_application/res/base/base.dart';
import 'package:flutter_application/res/component/loading_wiget.dart';
import 'package:flutter_application/res/service/userservice.dart';
import 'package:flutter_application/res/stream/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  User user;
  ProfilePage(this.user);
  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  Base base = new Base();
  ProfileBloc profile_bloc = new ProfileBloc();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  String password = "";
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getInfoUser();
  }

  void getInfoUser() {
    setState(() {
      isLoading = true;
    });
    UserService.getInfobyId(widget.user.userId).then((value) => {
          if (value != null)
            {
              _usernameController =
                  new TextEditingController(text: value.username),
              _nameController = new TextEditingController(text: value.name),
              _phoneController = new TextEditingController(text: value.phone),
              _emailController = new TextEditingController(text: value.email),
              setState((() {
                password = value.password;
                isLoading = false;
              }))
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        iconTheme:
            IconThemeData(color: Color.fromARGB(136, 6, 54, 113), size: 40),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Thông tin cá nhân',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: isLoading
          ? LoaderTransparent(Colors.grey.shade800)
          : Container(
              color: Colors.transparent,
              child: LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                            child: Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 70,
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/user.png',
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 1,
                                  right: 1,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.deepOrange,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: const [
                                        Color.fromARGB(136, 6, 54, 113),
                                        Color.fromARGB(255, 135, 164, 206)
                                      ])),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 4),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.fromSwatch()
                                            .copyWith(secondary: Colors.red),
                                        hintColor: Colors.white,
                                      ), // set color here
                                      child: StreamBuilder(
                                        stream: profile_bloc.usernameStream,
                                        builder: (context, snap) => TextField(
                                          controller: _usernameController,
                                          cursorColor: Colors.white,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            enabled: false,
                                            disabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                            labelText: "Username",
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            floatingLabelStyle:
                                                TextStyle(color: Colors.white),
                                            prefixIcon: SizedBox(
                                              height: 70,
                                              width: 50,
                                              child: Image.asset(
                                                'assets/images/ic_username.png',
                                                color: Colors.white,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 4),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.fromSwatch()
                                            .copyWith(secondary: Colors.red),
                                        hintColor: Colors.white,
                                      ), // set color here
                                      child: StreamBuilder(
                                        stream: profile_bloc.nameStream,
                                        builder: (context, snap) => TextField(
                                          controller: _nameController,
                                          cursorColor: Colors.white,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                            labelText: "Họ & tên",
                                            floatingLabelStyle:
                                                TextStyle(color: Colors.white),
                                            prefixIcon: SizedBox(
                                              height: 70,
                                              width: 50,
                                              child: Image.asset(
                                                'assets/images/ic_username.png',
                                                color: Colors.white,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 4),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.fromSwatch()
                                            .copyWith(secondary: Colors.red),
                                        hintColor: Colors.white,
                                      ), // set color here
                                      child: StreamBuilder(
                                        stream: profile_bloc.emailStream,
                                        builder: (context, snap) => TextField(
                                          controller: _emailController,
                                          cursorColor: Colors.white,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                            labelText: "Email",
                                            floatingLabelStyle:
                                                TextStyle(color: Colors.white),
                                            prefixIcon: SizedBox(
                                              height: 70,
                                              width: 50,
                                              child: Image.asset(
                                                'assets/images/ic_mail.png',
                                                color: Colors.white,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 4),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.fromSwatch()
                                            .copyWith(secondary: Colors.red),
                                        hintColor: Colors.white,
                                      ), // set color here
                                      child: StreamBuilder(
                                        stream: profile_bloc.phoneStream,
                                        builder: (context, snap) => TextField(
                                          controller: _phoneController,
                                          cursorColor: Colors.white,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            labelText: "Số điện thoại",
                                            floatingLabelStyle:
                                                TextStyle(color: Colors.white),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                            // labelText: "Tên",
                                            prefixIcon: SizedBox(
                                              height: 70,
                                              width: 50,
                                              child: Image.asset(
                                                'assets/images/ic_phone.png',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        height: 70,
                                        width: 200,
                                        child: Align(
                                            child: ElevatedButton(
                                          onPressed: () {
                                            _editSavePress();
                                          },
                                          child: Text(
                                            "Lưu",
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white),
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
                                            )),
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
                  ),
                );
              }),
            ),
    );
  }

  _editSavePress() {
    var isValid = profile_bloc.isValid(
        _nameController.text, _phoneController.text, _emailController.text);
    if (isValid) {
      // fetchPostUser(_nameController.text, _passwordController.text,
      //     _emailController.text, _phoneController.text);
      UserService.putUser(
              widget.user.userId,
              _nameController.text,
              _emailController.text,
              _phoneController.text,
              password,
              _usernameController.text)
          .then((value) => {
                if (value)
                  {
                    base.showToastSucces(context, 'Đã cập nhật thông tin'),
                    getInfoUser()
                  }
              });
    } else {
      base.showToastError(context, 'không thể cập nhật thông tin');
    }
  }
}
