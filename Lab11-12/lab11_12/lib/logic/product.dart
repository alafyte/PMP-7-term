import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final double rating;
  final bool isOnSale;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.isOnSale,
  });

  // Convert a Product to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'rating': rating,
      'isOnSale': isOnSale,
    };
  }

  // Convert a Firestore document into a Product
  factory Product.fromDocument(DocumentSnapshot doc) {
    return Product(
      id: doc.id,
      name: doc['name'],
      price: doc['price'],
      imageUrl: doc['imageUrl'],
      rating: doc['rating'],
      isOnSale: doc['isOnSale'],
    );
  }
}
