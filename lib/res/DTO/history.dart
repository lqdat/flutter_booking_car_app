import 'package:tiengviet/tiengviet.dart';

class History {
  final String userId;
  final String id;
  late final String carId;
  final int price;
  final String date;
  final String from_address;
  final String to_address;
  final String car_name;
  final int rating;
  final int distance;
  final String text;
  final bool status;

  History({
    required this.distance,
    required this.rating,
    required this.userId,
    required this.id,
    required this.carId,
    required this.price,
    required this.date,
    required this.from_address,
    required this.to_address,
    required this.car_name,
    required this.text,
    required this.status,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      distance: json['distance'],
      text: json['text'],
      rating: json['rating'],
      userId: json['userId'],
      id: json['id'],
      carId: json['carId'],
      price: json['price'],
      date: json['date'],
      from_address: TiengViet.parse(json['from_address']),
      car_name: json['car_name'],
      to_address: TiengViet.parse(json['to_address']),
      status: json['status'],
    );
  }
}
