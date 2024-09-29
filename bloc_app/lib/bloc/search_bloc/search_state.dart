import 'package:bloc_app/models/product_data_model.dart';

abstract class SearchState {}

class SearchIntitalState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchErrorConnectState extends SearchState {
  final String error;

  SearchErrorConnectState({required this.error});
}

class SearchErrorNotFoundState extends SearchState {
  final String error;

  SearchErrorNotFoundState({required this.error});
}

class SearchSuccessState extends SearchState {
  final List<ProductDataModel> products;

  SearchSuccessState({required this.products});
}
