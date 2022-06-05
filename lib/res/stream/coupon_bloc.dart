// ignore_for_file: unnecessary_new

import 'dart:async';

import 'package:flutter_application/res/DTO/coupont.dart';

class CouponStream {
  StreamController _selectedController = new StreamController.broadcast();

  get stream => _selectedController.stream;

  var currentSelected = 0;

  void selectItem(int index) {
    currentSelected = index;
    _selectedController.sink.add(currentSelected);
  }

  bool isSelected(int index) {
    return index == currentSelected;
  }

  Coupon getCurrentCar(List<Coupon> CouponList) {
    if (CouponList.isEmpty) {
      return Coupon(
        expiration_Date: '',
        name: '',
        id: '',
        code: '',
        prepayment: 0,
      );
    }
    return CouponList.elementAt(currentSelected);
  }

  void dispose() {
    _selectedController.close();
  }
}
