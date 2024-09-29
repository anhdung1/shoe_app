class OrderItemsDataModel {
  final String productTitle;
  final double productPrice;
  final String productImage;

  OrderItemsDataModel(
      {required this.productTitle,
      required this.productPrice,
      required this.productImage});
  Map<String, dynamic> toMap() {
    return {
      "productImage": productImage,
      "productTitle": productTitle,
      "productPrice": productPrice
    };
  }

  factory OrderItemsDataModel.fromMap(Map<String, dynamic> map) {
    return OrderItemsDataModel(
        productImage: map['productImage'] ?? "",
        productTitle: map['productTitle'] ?? "",
        productPrice: map["productPrice"] ?? 0.0);
  }
}
