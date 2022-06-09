// ignore_for_file: non_constant_identifier_names

class Category {
  final int id, parent_id;
  final String name, slug;
  Category({this.parent_id, this.slug, this.id, this.name});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'] as int,
        name: json['name'] as String,
        slug: json['slug'] as String,
        parent_id: json['parent_id'] as int);
  }
}
