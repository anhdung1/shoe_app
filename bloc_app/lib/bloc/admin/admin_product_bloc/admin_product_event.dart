abstract class AdminProductEvent {}

class AdminAddProductEvent extends AdminProductEvent {
  final String title;
  final String description;
  final String image;
  final String price;
  final String category;

  AdminAddProductEvent(
      {required this.title,
      required this.description,
      required this.image,
      required this.price,
      required this.category});
}
