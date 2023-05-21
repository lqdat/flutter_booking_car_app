import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/res/DTO/coupont.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class HorizontalCoupon extends StatefulWidget {
  Coupon coupon;
  HorizontalCoupon(this.coupon);
  @override
  State<HorizontalCoupon> createState() => _HorizontalCouponState();
}

class _HorizontalCouponState extends State<HorizontalCoupon> {
  DateFormat format =DateFormat("dd.MM.yyyy HH:mm a");
  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xffcbf3f0);
    const Color secondaryColor = Color(0xff368f8b);

    return CouponCard(
      height: 150,
      backgroundColor: primaryColor,
      curveAxis: Axis.vertical,
      firstChild: Container(
        decoration: const BoxDecoration(
          color: secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.coupon.prepayment.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'VNĐ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(color: Colors.white54, height: 0),
            Expanded(
              child: Center(
                child: Text(
                  widget.coupon.Code,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      secondChild: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(
              'Mã ưu đãi ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            Spacer(),
            Text(
              widget.coupon.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text(
              'Hạn sử dụng đến : '+ format.format(DateTime.tryParse(widget.coupon.expirationDate)??DateTime.now()).toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
