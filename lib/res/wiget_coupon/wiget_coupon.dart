import 'package:flutter/material.dart';
import 'package:flutter_application/res/DTO/coupont.dart';
import 'package:flutter_application/res/component/emty_wiget.dart';
import 'package:flutter_application/res/service/couponservice.dart';
import 'package:flutter_application/res/stream/coupon_bloc.dart';
import 'package:flutter_application/res/wiget_coupon/coupon.dart';

class WidgetCoupon extends StatefulWidget {
  @override
  State<WidgetCoupon> createState() => _WidgetCouponState();
}

class _WidgetCouponState extends State<WidgetCoupon> {
  CouponStream _couponStream = new CouponStream();
  bool isLoading = false;
  List<Coupon> listCoupon = [];

  void getlistCoupon() async {
    setState(() {
      isLoading = true;
    });
    await CouponService.getCoupon().then((value) => setState(() {
          value.sort((a, b) {
            DateTime aDate = DateTime.parse(a.expiration_Date);
            DateTime bDate = DateTime.parse(b.expiration_Date);
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
        body: Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
            child: listCoupon.length > 0
                ? StreamBuilder(
                    stream: _couponStream.stream,
                    builder: (context, snapshot) {
                      return new ListView.builder(
                        itemBuilder: (context, index) {
                          return HorizontalCouponExample1();
                        },
                        itemCount: listCoupon.length,
                        scrollDirection: Axis.vertical,
                      );
                    },
                  )
                : Empty('Chưa có mã giảm giá')));
  }
}
