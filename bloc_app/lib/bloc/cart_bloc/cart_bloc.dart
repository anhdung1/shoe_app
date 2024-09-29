import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_app/bloc/cart_bloc/cart_event.dart';
import 'package:bloc_app/bloc/cart_bloc/cart_state.dart';
import 'package:bloc_app/local_variable.dart';

import 'package:bloc_app/models/cart_data_model.dart';
import 'package:bloc_app/models/orders_data_model.dart';
import 'package:bloc_app/response/cart_response.dart';
import 'package:bloc_app/response/orders_response.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({CartState? initialState})
      : super(initialState ?? CartIntitalProductState()) {
    on<CartFetchingProductEvent>(_onFetching);
    on<CartAddProductEvent>(_addToCart);
    on<CartBackInitialEvent>(_back);
    on<CartCheckOutEvent>(_checkOut);
    on<CartReloadEvent>(_cartReload);
    on<ProductDecrementQuantityEvent>(_decrementProduct);
    on<ProductIncrementQuantityEvent>(_incrementProduct);
    on<ProductFetchingEvent>(_initialQuantity);
    on<CartPayEvent>(_pay);
    on<CartRemoveProductEvent>(_removeProduct);
  }

  FutureOr<void> _onFetching(
      CartFetchingProductEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingProductState());
    List<CartDataModel> carts = await CartResponse.fetchingCart(event.userId);
    if (carts.isNotEmpty) {
      emit(CartSuccessProductState(cart: carts));
    } else {
      emit(CartEmptyState());
    }
  }

  FutureOr<void> _addToCart(
      CartAddProductEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingProductState());

    CartDTO cartDTO =
        CartDTO(userId: event.userId, productId: event.producId, quantity: 1);
    dynamic isSuccess = await CartPost.fetchingCart(cartDTO);

    if (isSuccess == true) {
      event.cartBloc.add(CartFetchingProductEvent(userId: userId));
      return emit(CartAddSuccessProductState());
    } else if (isSuccess == false) {
      emit(CartAddErrorProductState(error: "error"));
    }
    emit(CartAddErrorProductState(error: isSuccess.toString()));
  }

  void _back(CartBackInitialEvent event, Emitter<CartState> emit) async {
    emit(CartIntitalProductState());
  }

  Future<void> _checkOut(
      CartCheckOutEvent event, Emitter<CartState> emit) async {
    var price = await CheckOut.fetchingPrice(event.userName);

    if (price == false || price is String) {
      emit(CartErrorProductState());
    } else {
      emit(CartCheckOutState(price: price));
    }
  }

  FutureOr<void> _cartReload(
      CartReloadEvent event, Emitter<CartState> emit) async {
    CartDTO cartDTO = CartDTO(
        userId: event.userId,
        productId: event.productId,
        quantity: event.quantity);
    await CartReload.fetchingCart(cartDTO);
  }

  FutureOr<void> _decrementProduct(
      ProductDecrementQuantityEvent event, Emitter<CartState> emit) async {
    if (event.quantity > 1) {
      int quantity = event.quantity - 1;
      emit(ProductChangeQuantityState(quantity: quantity));
      CartDTO cartDTO = CartDTO(
          userId: userId, productId: event.productId, quantity: quantity);
      await CartReload.fetchingCart(cartDTO);
      event.cartBloc.add(CartCheckOutEvent(userName: userName));
    }
  }

  FutureOr<void> _incrementProduct(
      ProductIncrementQuantityEvent event, Emitter<CartState> emit) async {
    int quantity = event.quantity + 1;
    emit(ProductChangeQuantityState(quantity: quantity));
    CartDTO cartDTO =
        CartDTO(userId: userId, productId: event.productId, quantity: quantity);
    await CartReload.fetchingCart(cartDTO);
    event.cartBloc.add(CartCheckOutEvent(userName: userName));
  }

  FutureOr<void> _initialQuantity(
      ProductFetchingEvent event, Emitter<CartState> emit) {
    emit(ProductChangeQuantityState(quantity: event.quantity));
  }

  Future<List<Map<String, dynamic>>> getCarts(carts) async {
    List<OrderDTOModel> orders = [];

    for (CartDataModel cart in carts) {
      OrderDTOModel order =
          OrderDTOModel(productId: cart.productId, quantity: cart.quantity);
      orders.add(order);
    }
    List<Map<String, dynamic>> jsonList =
        orders.map((order) => order.toMap()).toList();
    return jsonList;
  }

  FutureOr<void> _pay(CartPayEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingProductState());

    var isSuccess = await CartPay.fetchingCart();
    List<Map<String, dynamic>> orderItems = await getCarts(event.carts);
    var addToOrderIsSuccess =
        await OrdersResponse.createOrder(event.totalAmount, orderItems);
    if (isSuccess == true && addToOrderIsSuccess == "Success") {
      emit(CartPaySuccessState());
    } else {
      emit(CartPayErrorState());
    }
  }

  FutureOr<void> _removeProduct(
      CartRemoveProductEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingProductState());
    CartDTO cartDTO =
        CartDTO(userId: event.userId, productId: event.productId, quantity: 1);
    var isSuccess = await CartRemove.removeCart(cartDTO);

    if (isSuccess == true) {
      add(CartFetchingProductEvent(userId: event.userId));
    } else {
      emit(CartErrorProductState());
    }
  }
}
