import 'package:bloc_app/models/order_items_data_model.dart';

abstract class OrderDetailsState {}

class OrderDetailsFetchingSuccessState extends OrderDetailsState {
  final List<OrderItemsDataModel> orderItems;
  final int number;
  OrderDetailsFetchingSuccessState(
      {required this.orderItems, required this.number});
}

class OrderDetailsFetchingErrorState extends OrderDetailsState {}

class OrderLoadingState extends OrderDetailsState {}
