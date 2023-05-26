
class User {
  final String userId;
  final String userName;
  final String email;
  final String password;
  final String phone;
  final String name;
  final bool status;
  final String URLImage;
  
  const User(
      {required this.userId,
      required this.userName,
      required this.password,
      required this.email,
      required this.phone,
      required this.status,
      required this.name,
      required this.URLImage});

  factory User.fromJson(Map<String, dynamic> json,String Username) {
    return User(
        userId: json['Id'],
        userName: Username,
        password: "",
        email: json['Email'],
        phone: json['SDT'],
        name: json['TenHienThi'],
        status: json['Status'],
        URLImage: json['URLImage'],
    );
}}
class ResponeMessage{
  final String Message;
  final int StatusCode;
  const ResponeMessage(
    {
      required this.Message,
      required this.StatusCode
    }
  );
  factory ResponeMessage.fromJson(Map<String, dynamic> json,int StatusCode) {
    return ResponeMessage(
        Message: json['value'],
        StatusCode: StatusCode
    );
}}