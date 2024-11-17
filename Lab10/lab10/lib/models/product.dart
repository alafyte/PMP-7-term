class Product {
  final int id;
  final String name;
  final String image;
  final int rating;
  final double price;
  final bool isOnSale;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.price,
    required this.isOnSale,
    this.isFavorite = false,
  });
}
