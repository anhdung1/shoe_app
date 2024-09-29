import 'dart:convert';

import 'package:bloc_app/models/catagory_data.dart';

class ProductDataModel {
  final double price;
  final String title;
  final String description;
  final CategoryModel category;
  final String imagenetwork;
  final double rate;
  final int count;
  final int id;

  ProductDataModel(
      {required this.price,
      required this.title,
      required this.description,
      required this.category,
      required this.imagenetwork,
      required this.rate,
      required this.count,
      required this.id});

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'title': title,
      'description': description,
      'category': category.toMap(),
      'image': imagenetwork,
      'rate': rate,
      'count': count,
    };
  }

  factory ProductDataModel.fromMap(Map<String, dynamic> map) {
    return ProductDataModel(
      price: map['price']?.toDouble() ?? 0.0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: CategoryModel.fromMap(map['category'] ?? {}),
      imagenetwork: map['image'] ?? '',
      count: map['count'] ?? 0,
      rate: map['rate']?.toDouble() ?? 0.0,
      id: map["id"] ?? -1,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDataModel.fromJson(String source) {
    return ProductDataModel.fromMap(json.decode(source));
  }
}
