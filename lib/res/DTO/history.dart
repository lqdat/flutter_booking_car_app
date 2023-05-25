import 'package:tiengviet/tiengviet.dart';

class History {
  final String userId;
  final String id;
  late final String carId;
  final String price;
  final String date;
  final String from_address;
  final String to_address;
  final String car_name;
  final double rating;
  final double distance;
  final String text;
  final int status;
  final String voucherId;

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
    required this.voucherId
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      distance: json['KhoangCach'],
      text: json['DanhGia'],
      rating: json['Sao']!=null? json['Sao']:0,
      userId: json['TaiKhoan_Id'],
      id: json['Id'],
      carId: json['Xe_Id'],
      price: json['GiaTien'],
      date: json['NgayDat'],
      from_address: TiengViet.parse(json['DiaDiemDen']),
      car_name: json['DM_Xe']!=null ? TiengViet.parse(json['DM_Xe']['Name']) :"",
      to_address: TiengViet.parse(json['DiaDiemDi']),
      status: json['TrangThai'],
      voucherId: json['GiamGia_Id']
    );
  }
}
