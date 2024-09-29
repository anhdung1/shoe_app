abstract class AdminFilterEvent {}

class AdminFitlerOrderEvent extends AdminFilterEvent {
  final String code;

  AdminFitlerOrderEvent({required this.code});
}

class AdminChangeOrderEvent extends AdminFilterEvent {
  final String status;

  AdminChangeOrderEvent({required this.status});
}
