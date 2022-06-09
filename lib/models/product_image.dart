// ignore_for_file: non_constant_identifier_names

class ProductImage {
  final int id, product_id;
  final String path;
  ProductImage({this.product_id, this.path, this.id});
  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
        id: json['id'] as int,
        product_id: json['product_id'] as int,
        path: json['path'] as String);
  }
}
