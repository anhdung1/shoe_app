import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_app/bloc/product_bloc/product_event.dart';
import 'package:bloc_app/bloc/product_bloc/product_state.dart';
import 'package:bloc_app/models/product_data_model.dart';

import 'package:bloc_app/response/product_response.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductInitialFetchEvent>(productInitialFetchEvent);
    on<ProductViewEvent>(productViewEvent);
    on<ProductAddEvent>(_add);
  }
  void productInitialFetchEvent(
      ProductInitialFetchEvent event, Emitter<ProductState> emit) async {
    emit(ProductFetchingLoadingState());
    List<ProductDataModel> products = await ProductResponse.fetchProduct();

    emit(ProductFetchingSucessState(products: products));
  }

  FutureOr<void> productViewEvent(
      ProductViewEvent event, Emitter<ProductState> emit) {}

  FutureOr<void> _add(ProductAddEvent event, Emitter<ProductState> emit) async {
    emit(ProductFetchingLoadingState());
  }
}
