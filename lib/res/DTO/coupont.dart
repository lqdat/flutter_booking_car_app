import 'package:tiengviet/tiengviet.dart';

class Coupon {
  final String id;
  final int prepayment;
  final String name;
  final String Code;
  final String expirationDate;

  Coupon(
      {required this.id,
      required this.prepayment,
      required this.name,
      required this.Code,
      required this.expirationDate});

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['Id'],
      prepayment: json['Prepayment'],
      name: json['Name'],
      Code: json['Code'],
      expirationDate: json['ExpretionDate'],
    );
  }
}
