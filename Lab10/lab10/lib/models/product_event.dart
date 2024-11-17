abstract class ProductEvent {}

class LoadProductsEvent extends ProductEvent {}
class ToggleFavoriteEvent extends ProductEvent {
  final int productId;
  ToggleFavoriteEvent(this.productId);
}
