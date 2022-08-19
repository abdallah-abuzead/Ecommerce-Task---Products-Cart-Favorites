class Product {
  late String name;
  late String description;
  late double price;
  late double salePrice;
  late int stockQuantity;
  late String imagePath;
  int purchaseQuantity = 0;
  bool isFavorite = false;
  bool isInCart = false;

  Product({
    required this.name,
    required this.description,
    required this.stockQuantity,
    required this.imagePath,
    required this.price,
    required this.salePrice,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

  void toggleInCart() {
    isInCart = !this.isInCart;
  }
}
