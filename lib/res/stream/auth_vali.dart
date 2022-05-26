// ignore_for_file: prefer_final_fields, unnecessary_new

import 'dart:async';

class AuthValid {
  StreamController _nameController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passwordController = new StreamController();
  StreamController _phoneController = new StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passwordStream => _passwordController.stream;
  Stream get phoneStream => _phoneController.stream;

  bool isValid(String name, String password, String phone, String email) {
    if (name.isEmpty) {
      _nameController.sink.addError("Vui lòng nhập tên");
      return false;
    }
    _nameController.sink.add("");
    if (password.isEmpty || password.length < 5) {
      _passwordController.sink.addError("Mật khẩu phải có it nhất 6 ký tự");
      return false;
    }
    _passwordController.sink.add("");
    if (phone.isEmpty) {
      _phoneController.sink.addError("Vui lòng nhập số điện thoại");
      return false;
    }
    _phoneController.sink.add("");
    if (email.isEmpty) {
      _emailController.sink.addError("Vui lòng nhập tên");
      return false;
    }
    _emailController.sink.add("");

    return true;
  }

  void dispose() {
    _passwordController.close();
    _nameController.close();
    _phoneController.close();
    _emailController.close();
  }
}
