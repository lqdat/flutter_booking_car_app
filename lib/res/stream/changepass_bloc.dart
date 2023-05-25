// ignore_for_file: unnecessary_new, prefer_final_fields

import 'dart:async';

class ChangePassStream {
  StreamController _passOld = new StreamController.broadcast();
  StreamController _passNew = new StreamController.broadcast();

  Stream get passOldStream => _passOld.stream;
  Stream get passNewStream => _passNew.stream;


  bool isValid(String passOld, String passNew) {
    if (passOld.isEmpty) {
      _passOld.sink.addError("Chưa mật khẩu cũ");
      return false;
    }
    _passOld.sink.add("");

       if (passNew.isEmpty) {
      _passNew.sink.addError("Chưa mật khẩu mới");
      return false;
    }
    _passOld.sink.add("");
  
    return true;
  }

  void dispose() {
    _passOld.close();
    _passNew.close();

  }
}
