class History {
  final String userId;
  final String id;
  final int carId;
  final int price;
  final String date;
  final String from_address;
  final String to_address;
  final String car_name;
  final int rating;
  final int distance;
  final String text;

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
        from_address: json['from_address'],
        car_name: json['car_name'],
        to_address: json['to_address']);
  }
}
