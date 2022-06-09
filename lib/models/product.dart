// ignore_for_file: non_constant_identifier_names

class Product {
  final int id, mitra_id, status, kontrak;
  final String sku,
      name,
      slug,
      price,
      weight,
      width,
      height,
      length,
      short_description,
      description,
      mitra,
      path;

  Product(
      {this.id,
      this.mitra_id,
      this.sku,
      this.name,
      this.slug,
      this.price,
      this.weight,
      this.width,
      this.height,
      this.length,
      this.short_description,
      this.description,
      this.status,
      this.mitra,
      this.path,
      this.kontrak});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] as int,
        mitra_id: json['mitra_id'] as int,
        sku: json['sku'] as String,
        name: json['name'] as String,
        slug: json['slug'] as String,
        price: json['price'] as String,
        weight: json['weight'] as String,
        width: json['width'] as String,
        height: json['height'] as String,
        length: json['length'] as String,
        short_description: json['short_description'] as String,
        description: json['description'] as String,
        status: json['status'] as int,
        mitra: json['mitra'] as String,
        path: json['path'] as String,
        kontrak: json['kontrak'] as int);
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['mitra_id'] = mitra_id;
    map['sku'] = sku;
    map['name'] = name;
    map['slug'] = slug;
    map['price'] = price;
    map['weight'] = weight;
    map['width'] = width;
    map['height'] = height;
    map['length'] = length;
    map['short_description'] = short_description;
    map['description'] = description;
    map['status'] = status;
    map['mitra'] = mitra;
    map['path'] = path;
    map['kontrak'] = kontrak;
    return map;
  }
}
