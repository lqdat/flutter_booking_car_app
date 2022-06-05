class Car {
  final String name;
  final int price;
  final String id;
  const Car({required this.name, required this.price, required this.id});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(name: json['name'], price: json['price'], id: json['id']);
  }
}
