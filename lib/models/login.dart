// ignore_for_file: non_constant_identifier_names

class Login {
  final int id;
  Login({this.id});
  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(id: json['id'] as int);
  }
}
