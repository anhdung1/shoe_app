import 'package:equatable/equatable.dart';

abstract class OrderDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderDetailsFetchingEvent extends OrderDetailsEvent {
  final String code;
  final String status;
  OrderDetailsFetchingEvent({required this.code, required this.status});
  @override
  List<Object?> get props => [code, status];
}
