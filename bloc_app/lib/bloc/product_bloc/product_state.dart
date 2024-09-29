import 'package:bloc_app/models/product_data_model.dart';

abstract class ProductState {}

abstract class ProductActionState extends ProductState {}

class ProductInitial extends ProductState {}

class ProductFetchingLoadingState extends ProductState {}

class ProductFetchingErrorState extends ProductState {}

class ProductFetchingSucessState extends ProductState {
  final List<ProductDataModel> products;

  ProductFetchingSucessState({required this.products});
}
