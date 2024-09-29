import 'dart:convert';

class OrdersDataModel {
  final String totalAmount;
  final String status;
  final String code;
  final int orderId;

  OrdersDataModel(
      {required this.totalAmount,
      required this.status,
      required this.code,
      required this.orderId});
  factory OrdersDataModel.fromMap(Map<String, dynamic> map) {
    return OrdersDataModel(
        totalAmount: map['totalAmount'] ?? "error",
        status: map["status"] ?? "error",
        code: map["code"] ?? "error",
        orderId: map["orderId"] ?? -1);
  }
}

class OrderDTOModel {
  final int productId;
  final int quantity;

  OrderDTOModel({
    required this.productId,
    required this.quantity,
  });
  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "quantity": quantity,
    };
  }

  String toJson() => jsonEncode(toMap());
}
