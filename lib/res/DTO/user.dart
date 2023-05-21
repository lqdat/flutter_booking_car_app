
class User {
  final String userId;
  final String userName;
  final String email;
  final String password;
  final String phone;
  final String name;
  final bool status;
  
  const User(
      {required this.userId,
      required this.userName,
      required this.password,
      required this.email,
      required this.phone,
      required this.status,
      required this.name});

  factory User.fromJson(Map<String, dynamic> json,String Username) {
    return User(
        userId: json['Id'],
        userName: Username,
        password: "",
        email: json['Email'],
        phone: json['SDT'],
        name: json['TenHienThi'],
        status: json['Status']
    );
}}