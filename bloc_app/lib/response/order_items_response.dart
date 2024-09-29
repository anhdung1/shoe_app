import 'dart:convert';

import 'package:bloc_app/ip_v4.dart';
import 'package:bloc_app/models/order_items_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderItemsResponse {
  static Future<List<OrderItemsDataModel>> fetchingOrderItems(
      String code) async {
    List<OrderItemsDataModel> orderItems = [];
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse("http://$ip:8080/user/orders/orderitems/$code"));
      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        OrderItemsDataModel orderItem =
            OrderItemsDataModel.fromMap(result[i] as Map<String, dynamic>);
        orderItems.add(orderItem);
      }

      return orderItems;
    } catch (e) {
      debugPrint("Errorr: $e");
      return [];
    }
  }
}
