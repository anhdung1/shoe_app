abstract class PagehomeEvent {}

class PageSelectEvent extends PagehomeEvent {
  final int tabIndex;

  PageSelectEvent({required this.tabIndex});
}
