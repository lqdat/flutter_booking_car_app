// ignore_for_file: must_be_immutable, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_application/res/DTO/car.dart';
import 'package:flutter_application/res/DTO/user.dart';
import 'package:flutter_application/res/base/base.dart';
import 'package:flutter_application/res/service/carservice.dart';
import 'package:flutter_application/res/service/historyservice.dart';
import 'package:flutter_application/res/stream/car_steam.dart';
import 'package:flutter_application/res/wiget_home/wigets/info_trip_wiget.dart';

class CarWiget extends StatefulWidget {
  String from_address;
  String to_address;
  double distance;
  User user;
  Function() close;
  CarWiget(
      this.distance, this.from_address, this.to_address, this.user, this.close);
  @override
  State<CarWiget> createState() => _CarWigetState();
}

class _CarWigetState extends State<CarWiget> {
  Base base = new Base();
  final _carStream = new CarStream();
  bool isLoading = false;
  List<Car> listCar = [];
  void getlistCar() async {
    await CarService.getCar().then((value) => setState(() {
          listCar = value;
        }));
  }

  int CarIdSelector = 0;
  @override
  void initState() {
    super.initState();
    getlistCar();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _carStream.stream,
      builder: (context, snapshot) {
        return Stack(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 137),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    child: Container(
                      constraints: BoxConstraints.expand(width: 120),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xff323643),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Text(
                              listCar.elementAt(index).name.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            padding: EdgeInsets.all(2),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xfff7f7f7),
                            ),
                            width: 64,
                            height: 64,
                            child: Center(
                              child: getImageCar(index),
                            ),
                          ),
                          Text(
                            listCar.elementAt(index).price.toString() + " VNĐ",
                            style: TextStyle(
                                color: _carStream.isSelected(index)
                                    ? Colors.white
                                    : Color(0xff606470),
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            _carStream.isSelected(index)
                                ? Color.fromARGB(136, 6, 54, 113)
                                : Colors.white)),
                    onPressed: () {
                      _carStream.selectItem(index);
                    },
                  );
                },
                itemCount: listCar.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Positioned(
              bottom: 48,
              right: 0,
              left: 0,
              height: 50,
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Tổng cộng (" "~" + _getDistanceInfo() + "): ",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Text(
                      _getTotal().toString() + " VNĐ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Chọn",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                  onPressed: widget.distance == 0
                      ? null
                      : () {
                          _postOrder();
                        },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        widget.distance == 0 ? Colors.grey : Color(0xff3277D8)),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Image? getImageCar(int index) {
    String id = listCar.elementAt(index).id.toString();
    switch (id) {
      case "1":
        return Image.asset("assets/images/ic_car_blue.png");
      case "2":
        return Image.asset("assets/images/ic_car_red.png");
      case "3":
        return Image.asset("assets/images/ic_car_green.png");
      case "4":
        return Image.asset("assets/images/ic_bus.png");
      default:
        return null;
    }
  }

  void closeCar() {
    widget.close();
  }

  String _getDistanceInfo() {
    double distanceInKM = widget.distance / 1000;
    return distanceInKM.toStringAsFixed(2) + " km";
  }

  double _getTotal() {
    double distanceInKM = widget.distance;
    return (distanceInKM.roundToDouble() *
        _carStream.getCurrentCar(listCar).price /
        1000);
  }

  _postOrder() async {
    setState(() {
      isLoading = true;
    });

    await HistoryService.postHistory(
            widget.user,
            widget.from_address,
            widget.to_address,
            DateTime.now(),
            _getTotal(),
            0,
            widget.distance.toInt(),
            "",
            _carStream.getCurrentCar(listCar).id,
            false)
        .then((value) => {
              if (value != null)
                {
                  setState(() {
                    isLoading = false;
                  }),
                  base.showToastSucces(context, 'Đã đặt xe thành công  !'),
                  showModalBottomSheet<void>(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    backgroundColor: Colors.white,
                    isDismissible: false,
                    // enableDrag: false,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        height: 500,
                        child: InfoTrip(
                          value.id,
                          widget.user,
                        ),
                      );
                    },
                  ),
                  widget.close(),
                }
              else
                {throw new Exception('Không thể lấy dữ liệu')}
            });
  }
}
