import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab10/models/product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final List<Product> _products = [
    Product(id: 1, name: 'Nike GTX', image: 'src/assets/big_shoes.png', rating: 5, price: 100.0, isOnSale: false),
    Product(id: 2, name: 'Nike Air Max', image: 'src/assets/model101.png', rating: 4, price: 120.0, isOnSale: true),
    Product(id: 3, name: 'Nike React', image: 'src/assets/big_shoes.png', rating: 3, price: 130.0, isOnSale: true),
  ];

  ProductBloc() : super(ProductLoading()) {
    on<LoadProductsEvent>((event, emit) {
      emit(ProductLoaded(_products));
    });

    on<ToggleFavoriteEvent>((event, emit) {
      final product = _products.firstWhere((product) => product.id == event.productId);
      product.isFavorite = !product.isFavorite;
      emit(ProductLoaded(List.from(_products)));
    });
  }
}
