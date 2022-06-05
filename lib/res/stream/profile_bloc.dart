// ignore_for_file: unnecessary_new, prefer_final_fields

import 'dart:async';

class ProfileBloc {
  StreamController _nameController = new StreamController.broadcast();
  StreamController _emailController = new StreamController.broadcast();
  StreamController _usernameController = new StreamController.broadcast();
  StreamController _phoneController = new StreamController.broadcast();

  Stream get nameStream => _nameController.stream;
  Stream get usernameStream => _usernameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get phoneStream => _phoneController.stream;

  bool isValid(String name, String phone, String email) {
    if (name.isEmpty) {
      _nameController.sink.addError("Chưa nhập tên");
      return false;
    }
    _nameController.sink.add("");

    if (phone.isEmpty) {
      _phoneController.sink.addError("Chưa nhập nhập số điện thoại");
      return false;
    }
    _phoneController.sink.add("");
    if (email.isEmpty) {
      _emailController.sink.addError("Chưa nhập emali");
      return false;
    }
    _emailController.sink.add("");

    return true;
  }

  void dispose() {
    _nameController.close();
    _phoneController.close();
    _emailController.close();
    _usernameController.close();
  }
}
