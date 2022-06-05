class User {
  final String userId;
  final String username;
  final String email;
  final String password;
  final String phone;
  final String name;

  const User(
      {required this.userId,
      required this.username,
      required this.email,
      required this.password,
      required this.phone,
      required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        phone: json['sdt'],
        name: json['name']);
  }
}
