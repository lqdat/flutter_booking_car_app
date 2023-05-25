// ignore_for_file: must_be_immutable, unnecessary_new

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application/res/DTO/car.dart';
import 'package:flutter_application/res/DTO/user.dart';
import 'package:flutter_application/res/base/base.dart';
import 'package:flutter_application/res/service/carservice.dart';
import 'package:flutter_application/res/service/historyservice.dart';
import 'package:flutter_application/res/service/notificationservice.dart';
import 'package:flutter_application/res/stream/car_steam.dart';
import 'package:flutter_application/res/wiget_home/wigets/info_trip_wiget.dart';
import '../../base/const.dart' as Contranst;
import 'dart:ui' as ui;

import '../../service/couponservice.dart';
import '../../wiget_coupon/wiget_coupon.dart';

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
  String? codeVoucher;
  double? voucherPrice;
  String? idVoucher;
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
          fit: StackFit.loose,
          children: <Widget>[
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  constraints: BoxConstraints.expand(height: 137),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: ElevatedButton(
                            child: Container(
                              constraints: BoxConstraints.expand(width: 120),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xff323643),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2))),
                                    child: Text(
                                      listCar.elementAt(index).name.toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
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
                                      child: getImageCar(
                                          listCar.elementAt(index).URLImage),
                                    ),
                                  ),
                                  Text(
                                    listCar.elementAt(index).price.toString() +
                                        " VNĐ",
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
                                // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(2)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        _carStream.isSelected(index)
                                            ? Color.fromARGB(136, 6, 54, 113)
                                            : Colors.white)),
                            onPressed: () {
                              _carStream.selectItem(index);
                            },
                          ));
                    },
                    itemCount: listCar.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 106,
              left: 10,
              right: 10,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Mã giảm giá : ",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          ElevatedButton.icon(
                            icon: Icon(
                              Icons.discount,
                              color: Colors.green,
                              size: 30.0,
                            ),
                            label: Text(
                              getTextVoucher(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WidgetCoupon(
                                          widget.user,
                                          (Id, price, code) =>
                                              _receiceData(Id, price, code))));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              padding: EdgeInsets.all(5),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 48,
              right: 10,
              left: 10,
              height: 50,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Đặt xe",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                      onPressed: widget.distance == 0
                          ? null
                          : () {
                              _postOrder();
                            },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            widget.distance == 0
                                ? Colors.transparent
                                : Color(0xff3277D8)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Image? getImageCar(String URLImage) {
    return Image.network(Contranst.URl + URLImage);
  }

  void closeCar() {
    widget.close();
  }

  String _getDistanceInfo() {
    double distanceInKM = widget.distance / 1000;
    return distanceInKM.toStringAsFixed(2) + " km";
  }

  double _getTotal() {
    double distanceInKM = widget.distance / 1000;
    double rs = 0;
    if (distanceInKM == 0) {
      return rs;
    }
    if (voucherPrice != null) {
      rs = (distanceInKM.roundToDouble() *
              _carStream.getCurrentCar(listCar).price) -
          voucherPrice!;
      if (rs < 0) {
        return 0;
      }
      return rs;
    } else {
      rs = (distanceInKM.roundToDouble() *
          _carStream.getCurrentCar(listCar).price);
      return rs;
    }
  }

  void _receiceData(String Id, int price, String code) {
    setState(() {
      idVoucher = Id;
      codeVoucher = code;
      voucherPrice = double.parse(price.toString());
    });
  }

  String getTextVoucher() {
    if (codeVoucher != null) {
      return 'Mã ' +
          codeVoucher.toString() +
          ' giảm ' +
          voucherPrice.toString();
    }
    return 'Chọn mã giảm giá...';
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
            false,
            idVoucher ?? null)
        .then((value) => {
              NotificationService.postNotify(
                  widget.user,
                  "Đặt xe thành công",
                  "Đặt xe từ " +
                      widget.from_address +
                      " đến " +
                      widget.to_address +
                      " số tiền " +
                      _getTotal().toString()),
              if (idVoucher != null)
                {
                  CouponService.updateCoupon(idVoucher!),
                },
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
                        child: InfoTrip(value.id, widget.user, true),
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
