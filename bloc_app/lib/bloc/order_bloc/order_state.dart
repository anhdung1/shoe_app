import 'package:bloc_app/models/orders_data_model.dart';

abstract class OrderState {}

class OrderFetchingSuccessState extends OrderState {
  final List<OrdersDataModel> orders;

  OrderFetchingSuccessState({required this.orders});
}

class OrderLoadingState extends OrderState {}

class OrderFetchingEmptyState extends OrderState {}
