// ignore_for_file: non_constant_identifier_names

class Kontrak {
  final int id, product_id, customer_id, status;
  final String path,
      created_at,
      updated_at,
      product,
      name_file,
      description,
      mitra,
      image;

  Kontrak(
      {this.description,
      this.mitra,
      this.image,
      this.id,
      this.product_id,
      this.customer_id,
      this.name_file,
      this.path,
      this.status,
      this.created_at,
      this.updated_at,
      this.product});
  factory Kontrak.fromJson(Map<String, dynamic> json) {
    return Kontrak(
        id: json['id'] as int,
        product_id: json['product_id'] as int,
        customer_id: json['customer_id'] as int,
        path: json['path'] as String,
        name_file: json['name_file'] as String,
        status: json['status'] as int,
        created_at: json['created_at'] as String,
        updated_at: json['updated_at'] as String,
        product: json['product'] as String,
        description: json['description'] as String,
        mitra: json['mitra'] as String,
        image: json['image'] as String);
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['product_id'] = product_id;
    map['customer_id'] = customer_id;
    map['path'] = path;
    map['name_file'] = name_file;
    map['status'] = status;
    map['created_at'] = created_at;
    map['updated_at'] = updated_at;
    map['product'] = product;
    map['description'] = description;
    map['mitra'] = mitra;
    map['image'] = image;
    return map;
  }
}
