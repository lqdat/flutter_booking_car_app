class History {
  final String userId;
  final String id;
  final int carId;
  final double price;
  final String date;
  final String from_address;
  final String to_address;
  final String car_name;

  History(
      {required this.userId,
      required this.id,
      required this.carId,
      required this.price,
      required this.date,
      required this.from_address,
      required this.to_address,
      required this.car_name});

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
        userId: json['userId'],
        id: json['id'],
        carId: json['carId'],
        price: json['price'],
        date: json['date'],
        from_address: json['from_address'],
        car_name: json['car_name'],
        to_address: json['to_address']);
  }
}
