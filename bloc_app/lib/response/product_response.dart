import 'dart:convert';
import 'dart:developer';

import 'package:bloc_app/ip_v4.dart';
import 'package:bloc_app/models/product_data_model.dart';

import 'package:http/http.dart' as http;

class ProductResponse {
  static Future<List<ProductDataModel>> fetchProduct() async {
    var client = http.Client();
    List<ProductDataModel> products = [];
    try {
      var response = await client.get(
          Uri.parse('http://$ip:8080/user/products'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-api-key': 'my_key'
          });
      List result = jsonDecode(utf8.decode(response.bodyBytes));
      for (int i = 0; i < result.length; i++) {
        ProductDataModel product =
            ProductDataModel.fromMap(result[i] as Map<String, dynamic>);
        products.add(product);
      }

      return products;
    } catch (e) {
      log("$e");
      return [];
    }
  }

  static Future<bool> createProduct(String title, String description,
      String image, String price, String category) async {
    var client = http.Client();

    try {
      var response = await client.post(
          Uri.parse('http://$ip:8080/user/products/admin'),
          body: jsonEncode({
            'title': title,
            'description': description,
            'image': image,
            'price': price,
            'category': category
          }),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-api-key': 'my_key'
          });

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      log("$e");
      return false;
    }
  }
}
