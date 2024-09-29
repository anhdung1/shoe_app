abstract class AdminEditStatusEvent {}

class AdminOnEditStatusEvent extends AdminEditStatusEvent {
  final String status;
  final String code;
  AdminOnEditStatusEvent({required this.status, required this.code});
}
