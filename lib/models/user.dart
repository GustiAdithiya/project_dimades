// ignore_for_file: non_constant_identifier_names

class User {
  final int id, user_id;
  final String name, email, password, telp, address, instansi;

  User(
      {this.user_id,
      this.telp,
      this.address,
      this.instansi,
      this.id,
      this.name,
      this.email,
      this.password});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] as int,
        user_id: json['user_id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
        telp: json['telp'] as String,
        address: json['address'] as String,
        instansi: json['instansi'] as String);
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = user_id;
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['telp'] = telp;
    map['address'] = address;
    map['instansi'] = instansi;
    return map;
  }
}
