import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_app/bloc/order_bloc/order_event.dart';
import 'package:bloc_app/bloc/order_bloc/order_state.dart';
import 'package:bloc_app/local_variable.dart';
import 'package:bloc_app/models/orders_data_model.dart';
import 'package:bloc_app/response/orders_response.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderLoadingState()) {
    on<OrderFetchingEvent>(_orderFetching);
  }

  FutureOr<void> _orderFetching(
      OrderFetchingEvent event, Emitter<OrderState> emit) async {
    List<OrdersDataModel> orders = await OrdersResponse.getOrders(userId);
    if (orders.isNotEmpty) {
      emit(OrderFetchingSuccessState(orders: orders));
    } else {
      emit(OrderFetchingEmptyState());
    }
  }
}
