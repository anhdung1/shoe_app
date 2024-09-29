import 'dart:async';

import 'package:bloc_app/bloc/search_bloc/search_event.dart';
import 'package:bloc_app/bloc/search_bloc/search_state.dart';
import 'package:bloc_app/models/product_data_model.dart';
import 'package:bloc_app/response/search_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchIntitalState()) {
    on<SearchFetchingEvent>(_searchfetching);
  }

  FutureOr<void> _searchfetching(
      SearchFetchingEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    List<ProductDataModel> products =
        await SearchResponse.fetchProduct(event.title);
    if (products.isNotEmpty) {
      return emit(SearchSuccessState(products: products));
    }
    return emit(SearchErrorNotFoundState(error: "Product Not Found"));
  }
}
