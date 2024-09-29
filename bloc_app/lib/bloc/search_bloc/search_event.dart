abstract class SearchEvent {}

class SearchFetchingEvent extends SearchEvent {
  final String title;

  SearchFetchingEvent({required this.title});
}
