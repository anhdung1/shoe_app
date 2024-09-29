import 'package:bloc_app/models/cart_data_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

// bên thông tin sản phẩm
class CartAddSuccessProductState extends CartState {}

class CartAddErrorProductState extends CartState {
  final String error;

  CartAddErrorProductState({required this.error});
}

class CartLoadingProductState
    extends CartState {} // CartLoading dùng chung khi gửi, tải dữ liệu

// tải giỏ hàng
class CartIntitalProductState extends CartState {}

class CartSuccessProductState extends CartState {
  final List<CartDataModel> cart;

  CartSuccessProductState({required this.cart});
}

class CartErrorProductState extends CartState {}

class CartEmptyState extends CartState {}

// thay đổi sản phẩm (thêm, xóa, tính tiền...)
class CartCheckOutState extends CartState {
  final double price;

  CartCheckOutState({required this.price});
  @override
  List<Object?> get props => [price];
}

class ProductChangeQuantityState extends CartState {
  final int quantity;

  ProductChangeQuantityState({required this.quantity});
  @override
  List<Object?> get props => [quantity];
}

class CartPaySuccessState extends CartState {}

class CartPayErrorState extends CartState {}

class CartRemoveProductSuccess extends CartState {}
