import 'dart:convert';
import 'package:bloc_app/ip_v4.dart';
import 'package:bloc_app/local_variable.dart';
import 'package:bloc_app/models/orders_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class OrdersResponse {
  static Future<String> createOrder(
      double totalAmount, List<Map<String, dynamic>> jsonList) async {
    Uri uri = Uri.parse("http://$ip:8080/user/orders/newOrders")
        .replace(queryParameters: {
      'totalAmount': totalAmount.toString(),
      'userId': userId.toString(),
    });

    var client = http.Client();

    try {
      var response = await client.post(
        uri,
        body: jsonEncode(jsonList),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return "Success";
      } else {
        return "Error: ${response.statusCode}";
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return "Error";
    } finally {
      client.close();
    }
  }

  static Future<String> editStatus(String code, String status) async {
    Uri uri = Uri.parse("http://$ip:8080/user/orders/edit/admin")
        .replace(queryParameters: {
      'code': code,
      'status': status,
    });

    var client = http.Client();

    try {
      var response = await client.patch(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-api-key': 'my_key'
        },
      );
      if (response.statusCode == 200) {
        return "Success";
      } else {
        return "Error: ${response.statusCode}";
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return "Error";
    } finally {
      client.close();
    }
  }

  static Future filterOrder(String code) async {
    Uri uri = Uri.parse("http://$ip:8080/user/orders/admin")
        .replace(queryParameters: {
      'code': code,
    });
    OrdersDataModel? order;
    var client = http.Client();

    try {
      var response = await client.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-api-key': 'my_key'
        },
      );

      if (response.statusCode == 200) {
        order = OrdersDataModel.fromMap(
            jsonDecode(response.body) as Map<String, dynamic>);
        return order;
      } else {
        return "Order Not Found";
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return "Error";
    } finally {
      client.close();
    }
  }

  static Future<List<OrdersDataModel>> getOrders(int userId) async {
    var client = http.Client();
    List<OrdersDataModel> orders = [];
    try {
      var response = await client.get(
          Uri.parse("http://$ip:8080/user/orders/$userId"),
          headers: {'Content-Type': 'application/json'});
      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        OrdersDataModel order =
            OrdersDataModel.fromMap(result[i] as Map<String, dynamic>);
        orders.add(order);
      }
      return orders;
    } catch (e) {
      debugPrint("Error11: $e");
      return [];
    }
  }
}
