import 'dart:convert';

class CartDataModel {
  final String productTitle;
  final double productPrice;
  final String productImage;
  final int quantity;
  final int productId;
  CartDataModel(
      {required this.productTitle,
      required this.productPrice,
      required this.productImage,
      required this.quantity,
      required this.productId});
  Map<String, dynamic> toMap() {
    return {'productTitle': productTitle, 'productPrice': productPrice};
  }

  factory CartDataModel.fromMap(Map<String, dynamic> map) {
    return CartDataModel(
        productTitle: map['productTitle'] ?? "",
        productPrice: map['productPrice'] ?? 0.0,
        productImage: map['productImage'] ?? "",
        quantity: map['quantity'] ?? 1,
        productId: map['productId'] ?? -1);
  }
  String toJson() => json.encode(toMap());
  factory CartDataModel.fromJson(String source) {
    return CartDataModel.fromMap(json.decode(source));
  }
}

class CartDTO {
  final int userId;
  final int productId;
  final int quantity;
  CartDTO(
      {required this.userId, required this.productId, required this.quantity});
  Map<String, int> toMap() {
    return {'userId': userId, 'productId': productId, 'quantity': quantity};
  }

  String toJson() => jsonEncode(toMap());
}
