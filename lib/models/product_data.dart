import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'product.dart';

class ProductData extends ChangeNotifier {
  int cartCount = 0;
  int favoritesCount = 0;
  List<Product> _products = [
    Product(
      name: 'Dell Inspiron 3593',
      description: 'Laptop Device',
      stockQuantity: 50,
      imagePath: 'images/products/laptop1.png',
      price: 21000.0,
      salePrice: 20000.0,
    ),
    Product(
      name: 'Dell Inspiron 3595',
      description: 'Gaming Device',
      stockQuantity: 0,
      imagePath: 'images/products/laptop2.jpg',
      price: 23000.0,
      salePrice: 23000.0,
    ),
  ];

  int get productsCount => _products.length;

  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    _products.forEach((product) {
      if (product.isInCart)
        total += product.purchaseQuantity * (product.price == product.salePrice ? product.price : product.salePrice);
    });
    return total;
  }

  void toggleProductFavorite(Product product) {
    product.toggleFavorite();
    product.isFavorite ? favoritesCount++ : favoritesCount--;
    notifyListeners();
  }

  void toggleProductInCart(Product product) {
    product.toggleInCart();
    product.isInCart ? cartCount++ : cartCount--;

    notifyListeners();
  }

  void increasePurchaseQuantity(Product product) {
    if (product.stockQuantity > product.purchaseQuantity) product.purchaseQuantity += 1;
    notifyListeners();
  }

  void decreasePurchaseQuantity(Product product) {
    if (product.purchaseQuantity > 0) product.purchaseQuantity -= 1;
    notifyListeners();
  }
}
