import 'package:bloc_app/bloc/cart_bloc/cart_bloc.dart';
import 'package:bloc_app/models/cart_data_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartAddProductEvent extends CartEvent {
  final int userId;
  final int producId;
  final String userName;
  final CartBloc cartBloc;
  CartAddProductEvent(this.cartBloc,
      {required this.userId, required this.producId, required this.userName});
}

class CartFetchingProductEvent extends CartEvent {
  final int userId;

  CartFetchingProductEvent({required this.userId});
}

class CartBackInitialEvent extends CartEvent {}

class CartCheckOutEvent extends CartEvent {
  final String userName;

  CartCheckOutEvent({required this.userName});
}

class CartReloadEvent extends CartEvent {
  final int quantity;
  final int userId;
  final int productId;

  CartReloadEvent(
      {required this.quantity, required this.userId, required this.productId});
}

class ProductIncrementQuantityEvent extends CartEvent {
  final int quantity;
  final int productId;
  final CartBloc cartBloc;
  ProductIncrementQuantityEvent(
      {required this.quantity,
      required this.productId,
      required this.cartBloc});
}

class ProductFetchingEvent extends CartEvent {
  final int quantity;

  ProductFetchingEvent({required this.quantity});
}

class ProductDecrementQuantityEvent extends CartEvent {
  final int quantity;
  final int productId;
  final CartBloc cartBloc;
  ProductDecrementQuantityEvent(
      {required this.quantity,
      required this.productId,
      required this.cartBloc});
  @override
  List<Object?> get props => [quantity];
}

class CartPayEvent extends CartEvent {
  final double totalAmount;
  final List<CartDataModel> carts;
  CartPayEvent({required this.totalAmount, required this.carts});
}

class CartPayBackToOrder extends CartEvent {}

class CartRemoveProductEvent extends CartEvent {
  final int productId;
  final int userId;

  CartRemoveProductEvent({required this.productId, required this.userId});
}
