abstract class ProductEvent {}

class ProductInitialFetchEvent extends ProductEvent {}

class ProductViewEvent extends ProductEvent {}

class ProductAddEvent extends ProductEvent {
  final String title;

  final String image;

  ProductAddEvent({
    required this.title,
    required this.image,
  });
}
