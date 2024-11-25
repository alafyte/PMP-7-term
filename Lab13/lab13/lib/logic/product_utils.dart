import 'dart:collection';

import 'product.dart';

class ProductService {
  final List<Product> _products = [];

  List<Product> getAllProducts() {
    return UnmodifiableListView(_products);
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  void addProduct(Product product) {
    if (_products.any((p) => p.id == product.id)) {
      throw Exception('Product with ID ${product.id} already exists.');
    }
    _products.add(product);
  }

  void updateProduct(Product updatedProduct) {
    final index = _products.indexWhere((product) => product.id == updatedProduct.id);
    if (index == -1) {
      throw Exception('Product with ID ${updatedProduct.id} not found.');
    }
    _products[index] = updatedProduct;
  }

  void deleteProduct(String id) {
    _products.removeWhere((product) => product.id == id);
  }
}
