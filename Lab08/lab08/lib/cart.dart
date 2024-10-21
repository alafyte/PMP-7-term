import 'package:hive/hive.dart';

part 'cart.g.dart';

@HiveType(typeId: 4)
class CartItem {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int productId;

  @HiveField(2)
  final String userName;

  CartItem(this.id, this.productId, this.userName);
}
