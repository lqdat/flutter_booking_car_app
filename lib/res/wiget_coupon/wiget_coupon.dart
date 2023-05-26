import 'package:flutter/material.dart';
import 'package:flutter_application/res/DTO/coupont.dart';
import 'package:flutter_application/res/component/emty_wiget.dart';
import 'package:flutter_application/res/service/couponservice.dart';
import 'package:flutter_application/res/stream/coupon_bloc.dart';
import 'package:flutter_application/res/wiget_coupon/coupon.dart';
import 'package:flutter_application/res/wiget_coupon/searchCoupon.dart';

import '../DTO/user.dart';
import '../component/loading_wiget.dart';

class WidgetCoupon extends StatefulWidget {
  @override
  User user;
  final Function(String, int, String) onSelect;
  WidgetCoupon(this.user, this.onSelect);
  State<WidgetCoupon> createState() => _WidgetCouponState();
}

class _WidgetCouponState extends State<WidgetCoupon> {
  CouponStream _couponStream = new CouponStream();
  bool isLoading = false;
  List<Coupon> listCoupon = [];

  Future<void> getlistCoupon() async {
    setState(() {
      isLoading = true;
    });
    await CouponService.getCoupon(widget.user).then((value) => setState(() {
          value.sort((a, b) {
            DateTime aDate = DateTime.parse(a.expirationDate);
            DateTime bDate = DateTime.parse(b.expirationDate);
            return bDate.compareTo(aDate);
          });
          setState(() {
            if (value.length > 0) {
              listCoupon = value;
              isLoading = false;
            } else
              listCoupon = [];
            isLoading = false;
          });
        }));
  }

  @override
  void initState() {
    super.initState();
    getlistCoupon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        iconTheme:
            IconThemeData(color: Color.fromARGB(136, 6, 54, 113), size: 40),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Mã giảm giá',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: isLoading
          ? LoaderTransparent(Colors.grey.shade800)
          : Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
              child: Column(
                children: <Widget>[
                  SearchInput(widget.user, () => getlistCoupon()),
                  Expanded(
                    child: listCoupon.length > 0
                        ? StreamBuilder(
                            stream: _couponStream.stream,
                            builder: (context, snapshot) {
                              return RefreshIndicator(onRefresh: () => getlistCoupon(),child: new ListView.builder(
                                itemBuilder: (context, index) {
                                  return HorizontalCoupon(
                                      listCoupon[index],
                                      (Id, price, code) =>
                                          receiceData(Id, price, code));
                                },
                                itemCount: listCoupon.length,
                                scrollDirection: Axis.vertical,
                              )
                              );
                            },
                          )
                        : Empty('Chưa có mã giảm giá'),
                  )
                ],
              )),
    );
  }

  void receiceData(String Id, int price, String code) {
    widget.onSelect(Id, price, code);
    Navigator.pop(context);
  }
}
