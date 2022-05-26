class Car {
  final String name;
  final int price;
  const Car({required this.name, required this.price});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(name: json['name'], price: json['price']);
  }
}
