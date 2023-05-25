class Car {
  final String name;
  final double price;
  final String id;
  final String URLImage;
  const Car(
      {required this.name,
      required this.price,
      required this.id,
      required this.URLImage});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
        name: json['Name'],
        price: double.parse(json['GiaTienTrenKm']),
        id: json['Id'],
        URLImage: json['URLImage']);
  }
}
