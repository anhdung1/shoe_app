import 'dart:convert';
import 'dart:developer';

import 'package:bloc_app/ip_v4.dart';
import 'package:bloc_app/local_variable.dart';
import 'package:bloc_app/models/cart_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CartResponse {
  static Future<List<CartDataModel>> fetchingCart(int userId) async {
    var client = http.Client();
    List<CartDataModel> carts = [];
    try {
      var response = await client.get(
          Uri.parse("http://$ip:8080/user/carts/$userId"),
          headers: {'Content-Type': 'application/json'});
      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        CartDataModel cart =
            CartDataModel.fromMap(result[i] as Map<String, dynamic>);
        carts.add(cart);
      }
      return carts;
    } catch (e) {
      debugPrint("$e");
      return carts;
    }
  }
}

class CartPay {
  static Future fetchingCart() async {
    var client = http.Client();
    try {
      var response = await client.delete(
          Uri.parse("http://$ip:8080/user/carts/pay/next/$userName"),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return true;
      }
      return response.body;
    } catch (e) {
      debugPrint("$e");
      return false;
    }
  }
}

class CartPost {
  static Future fetchingCart(
    CartDTO cart,
  ) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse("http://$ip:8080/user/carts"),
          headers: {'Content-Type': 'application/json'}, body: cart.toJson());

      if (response.statusCode == 200) {
        return true;
      }
      return response.body;
    } catch (e) {
      debugPrint("$e");
      return false;
    }
  }
}

class CheckOut {
  static Future fetchingPrice(String userName) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.parse("http://$ip:8080/user/carts/pay/$userName"),
          headers: {'Content-Type': 'application/json'});

      return jsonDecode(response.body);
    } catch (e) {
      debugPrint("$e");
      return false;
    }
  }
}

class CartReload {
  static Future<bool> fetchingCart(
    CartDTO cart,
  ) async {
    var client = http.Client();
    try {
      var response = await client.put(Uri.parse("http://$ip:8080/user/carts"),
          headers: {'Content-Type': 'application/json'}, body: cart.toJson());
      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      debugPrint("$e");
      return false;
    }
  }
}

class CartRemove {
  static Future removeCart(CartDTO cartDTO) async {
    var client = http.Client();

    try {
      var response = await client.delete(
          headers: {'Content-Type': 'application/json'},
          Uri.parse("http://$ip:8080/user/carts/remove"),
          body: cartDTO.toJson());
      if (response.statusCode == 200) {
        return true;
      }
      return response.statusCode;
    } catch (e) {
      log("$e");
      return e;
    }
  }
}
