// ignore_for_file: unnecessary_new

import 'dart:async';

import 'package:flutter_application/res/DTO/car.dart';

class CarStream {
  final _pickupController = new StreamController();

  get stream => _pickupController.stream;

  var currentSelected = 0;

  void selectItem(int index) {
    currentSelected = index;
    _pickupController.sink.add(currentSelected);
  }

  bool isSelected(int index) {
    return index == currentSelected;
  }

  Car getCurrentCar(List<Car> carList) {
    if (carList.isEmpty) {
      return Car(name: "", price: 0, id: "",URLImage: "");
    }
    return carList.elementAt(currentSelected);
  }

  void dispose() {
    _pickupController.close();
  }
}
