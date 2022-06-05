import 'package:tiengviet/tiengviet.dart';

class Coupon {
  final String id;
  final int prepayment;
  final String name;
  final String code;
  final String expiration_Date;

  Coupon(
      {required this.id,
      required this.prepayment,
      required this.name,
      required this.code,
      required this.expiration_Date});

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      prepayment: json['prepayment'],
      name: TiengViet.parse(json['name']),
      code: json['code'],
      expiration_Date: json['expirationDate'],
    );
  }
}
