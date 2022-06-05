import 'dart:convert';
import 'dart:io';

import 'package:flutter_application/res/DTO/coupont.dart';
import 'package:http/http.dart' as http;

class CouponService {
  static Future<List<Coupon>> getCoupon() async {
    String url = "https://627b30e4b54fe6ee00839593.mockapi.io/coupon";
    var res = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      List<dynamic> rs = json.decode(res.body).cast<Map<String, dynamic>>();
      List<Coupon> couponList =
          rs.map<Coupon>((json) => Coupon.fromJson(json)).toList();
      return couponList;
    } else {
      return [];
    }
  }
}
