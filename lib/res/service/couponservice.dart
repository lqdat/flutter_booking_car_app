import 'dart:convert';
import 'dart:io';
import 'package:flutter_application/res/DTO/user.dart';

import '../base/const.dart' as Constants;
import 'package:flutter_application/res/DTO/coupont.dart';
import 'package:http/http.dart' as http;

class CouponService {
  static Future<List<Coupon>> getCoupon(User user) async {
    var res = await http.get(
      Uri.parse(Constants.URl +
          'odata/DM_MaKhuyenMai?\$filter=TaiKhoan_Id eq guid\'' +
          user.userId +
          '\'' +
          'and Status eq 0'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      List<dynamic> rs =
          Map<String, dynamic>.from(json.decode(res.body))['value'];
      List<Coupon> couponList =
          rs.map<Coupon>((json) => Coupon.fromJson(json)).toList();
      return couponList;
    } else {
      return [];
    }
  }

  static Future<List<Coupon>> updateCoupon(String Id) async {
    var res = await http.patch(
      Uri.parse(Constants.URl + 'odata/DM_MaKhuyenMai(guid\'' + Id + '\')'),
      body: jsonEncode({
        "Status": 1,
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      List<dynamic> rs =
          Map<String, dynamic>.from(json.decode(res.body))['value'];
      List<Coupon> couponList =
          rs.map<Coupon>((json) => Coupon.fromJson(json)).toList();
      return couponList;
    } else {
      return [];
    }
  }
  static Future<Coupon?> getCouponbyId(String Id) async {
    var res = await http.get(
      Uri.parse(Constants.URl +
          'odata/DM_MaKhuyenMai(guid\''+Id+'\')'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      var rs =
          Map<String, dynamic>.from(json.decode(res.body));
      Coupon couponList = Coupon.fromJson(rs);
      return couponList;
    } else {
      return null;
    }
  }
}
