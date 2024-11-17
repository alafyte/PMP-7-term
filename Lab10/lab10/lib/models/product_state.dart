import 'package:lab10/models/product.dart';

abstract class ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);
}

class ProductLoading extends ProductState {}

class ProductError extends ProductState {}
