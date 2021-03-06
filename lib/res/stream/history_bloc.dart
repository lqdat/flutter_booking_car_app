// ignore_for_file: unnecessary_new

import 'dart:async';

import 'package:flutter_application/res/DTO/car.dart';
import 'package:flutter_application/res/DTO/history.dart';

class HistoryStream {
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

  History getCurrentCar(List<History> historyList) {
    if (historyList.isEmpty) {
      return History(
        car_name: '',
        carId: "",
        date: '',
        from_address: '',
        id: '',
        price: 0,
        to_address: '',
        userId: '',
        distance: 0,
        rating: 0,
        text: '',
        status: false,
      );
    }
    return historyList.elementAt(currentSelected);
  }

  void dispose() {
    _selectedController.close();
  }
}
