abstract class PagehomeState {
  final int tabIndex;

  PagehomeState({required this.tabIndex});
}

class PageInitialState extends PagehomeState {
  PageInitialState({required super.tabIndex});
}
