import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 3)
class Product {
  @HiveField(0)
  final int id;

  @HiveField(1)
  String productName;

  @HiveField(2)
  double price;

  Product(this.id, this.productName, this.price);
}
