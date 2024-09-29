import 'dart:async';

import 'package:bloc_app/bloc/admin/admin_filter_bloc/admin_filter_event.dart';
import 'package:bloc_app/bloc/admin/admin_filter_bloc/admin_filter_state.dart';
import 'package:bloc_app/models/orders_data_model.dart';
import 'package:bloc_app/response/orders_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminFilterBloc extends Bloc<AdminFilterEvent, AdminFilterState> {
  AdminFilterBloc() : super(AdminFilterInititalState()) {
    on<AdminFitlerOrderEvent>(_fitler);
  }

  FutureOr<void> _fitler(
      AdminFitlerOrderEvent event, Emitter<AdminFilterState> emit) async {
    var order = await OrdersResponse.filterOrder(event.code);
    if (order is OrdersDataModel) {
      return emit(AdminFilterSuccessState(order: order));
    }
    emit(AdminFilterErrorState(error: order));
  }
}
