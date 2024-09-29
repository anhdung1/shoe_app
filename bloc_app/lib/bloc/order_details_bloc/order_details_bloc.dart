import 'dart:async';

import 'package:bloc_app/bloc/order_details_bloc/order_details_event.dart';
import 'package:bloc_app/bloc/order_details_bloc/order_details_state.dart';
import 'package:bloc_app/models/order_items_data_model.dart';
import 'package:bloc_app/response/order_items_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  OrderDetailsBloc(super.initialState) {
    on<OrderDetailsFetchingEvent>(_onFetching);
  }
  int set(currentStatus) {
    int number = -1;
    List status = ["Packing", "Shipping", "Arriving", "Success"];
    for (int i = 0; i < status.length; i++) {
      if (currentStatus == status[i]) {
        number = i;
      }
    }
    return number;
  }

  FutureOr<void> _onFetching(
      OrderDetailsFetchingEvent event, Emitter<OrderDetailsState> emit) async {
    emit(OrderLoadingState());
    List<OrderItemsDataModel> orderItems =
        await OrderItemsResponse.fetchingOrderItems(event.code);

    if (orderItems.isEmpty) {
      emit(OrderDetailsFetchingErrorState());
    } else {
      emit(OrderDetailsFetchingSuccessState(
          orderItems: orderItems, number: set(event.status)));
    }
  }
}
