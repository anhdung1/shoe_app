import 'dart:convert';

import 'package:bloc_app/ip_v4.dart';
import 'package:bloc_app/models/catagory_data.dart';
import 'package:bloc_app/models/product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchResponse {
  static Future<List<ProductDataModel>> fetchProduct(String title) async {
    var client = http.Client();
    List<ProductDataModel> products = [];
    try {
      var response = await client.get(
          Uri.parse("http://$ip:8080/user/products/search?title=$title"),
          headers: <String, String>{'Content-Type': 'application/json'});

      var result = jsonDecode(utf8.decode(response.bodyBytes));
      for (int i = 0; i < result.length; i++) {
        ProductDataModel product =
            ProductDataModel.fromMap(result[i] as Map<String, dynamic>);

        products.add(product);
      }

      return products;
    } catch (e) {
      debugPrint("$e");

      return [];
    }
  }
}

class GetCategory {
  static fetchcategory(String title) async {
    var client = http.Client();
    List<CategoryModel> categories = [];
    try {
      var response = await client.get(
          Uri.parse("http://$ip:8080/user/categories"),
          headers: <String, String>{'Content-Type': 'application/json'});
      var result = jsonDecode(utf8.decode(response.bodyBytes));
      for (int i = 0; i < result.length; i++) {
        CategoryModel category =
            CategoryModel.fromMap(result[i] as Map<String, dynamic>);

        categories.add(category);
      }

      return categories;
    } catch (e) {
      debugPrint("$e");
      return "Error";
    }
  }
}
