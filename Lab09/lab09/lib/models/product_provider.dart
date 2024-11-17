import 'package:flutter/material.dart';
import 'product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(id: 1, name: 'Nike GTX', image: 'src/assets/big_shoes.png', rating: 5, price: 100.0, isOnSale: false),
    Product(id: 2, name: 'Nike Air Max', image: 'src/assets/model101.png', rating: 4, price: 120.0, isOnSale: true),
    Product(id: 3, name: 'Nike React', image: 'src/assets/big_shoes.png', rating: 3, price: 130.0, isOnSale: true),
  ];

  List<Product> get products => _products;

  List<Product> get favorites => _products.where((product) => product.isFavorite).toList();

  void toggleFavorite(int productId) {
    final product = _products.firstWhere((product) => product.id == productId);
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }
}
