import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_app/bloc/admin/admin_product_bloc/admin_product_event.dart';
import 'package:bloc_app/bloc/admin/admin_product_bloc/admin_product_state.dart';
import 'package:bloc_app/response/product_response.dart';

class AdminProductBloc extends Bloc<AdminProductEvent, AdminProductState> {
  AdminProductBloc() : super(AdminAddProductInitialState()) {
    on<AdminAddProductEvent>(_addProduct);
  }

  FutureOr<void> _addProduct(
      AdminAddProductEvent event, Emitter<AdminProductState> emit) async {
    emit(AdminAddProductLoadingState());
    var isSuccess = await ProductResponse.createProduct(event.title,
        event.description, event.image, event.price, event.category);
    if (isSuccess) {
      emit(AdminAddProductSuccessState());
    } else {
      emit(AdminAddProductErrorState());
    }
  }
}
