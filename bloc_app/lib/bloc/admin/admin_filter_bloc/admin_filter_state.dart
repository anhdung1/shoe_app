import 'package:bloc_app/models/orders_data_model.dart';

abstract class AdminFilterState {}

class AdminFilterInititalState extends AdminFilterState {}

class AdminFilterSuccessState extends AdminFilterState {
  final OrdersDataModel order;

  AdminFilterSuccessState({required this.order});
}

class AdminFilterErrorState extends AdminFilterState {
  final String error;

  AdminFilterErrorState({required this.error});
}
