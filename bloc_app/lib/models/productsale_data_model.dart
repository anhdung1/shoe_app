import 'dart:convert';

class ProductSaleDataModel {
  final int id;
  final double price;
  final String title;
  final String description;
  // final Map<String, dynamic> category;
  final List<dynamic> images;

  ProductSaleDataModel({
    required this.id,
    required this.price,
    required this.title,
    required this.description,
    // required this.category,
    required this.images,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'title': title,
      'description': description,
      // 'category': category,
      'images': images
    };
  }

  factory ProductSaleDataModel.fromMap(Map<String, dynamic> map) {
    return ProductSaleDataModel(
      price: map['price']?.toDouble() ?? 0,
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      // category: map['category'] ?? '',
      images: map['images'] ?? [],
    );
  }
  String toJson() => json.encode(toMap());
  factory ProductSaleDataModel.fromJson(String source) {
    return ProductSaleDataModel.fromMap(json.decode(source));
  }
}
