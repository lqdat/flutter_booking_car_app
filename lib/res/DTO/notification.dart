class Notify {
  final String taiKhoan_Id;
  final String title;
  final String id;
  final String content;
  final String date;
  const Notify(
      {required this.taiKhoan_Id,
      required this.title,
      required this.id,
      required this.content,
      required this.date});

  factory Notify.fromJson(Map<String, dynamic> json) {
    return Notify(
        title: json['TieuDe'],
        content: json['NoiDung'],
        id: json['Id'],
        taiKhoan_Id: json['taiKhoan_Id'],
        date: json['Ngay']);
  }
}