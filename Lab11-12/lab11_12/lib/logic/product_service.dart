import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab11_12/logic/product.dart';

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addProduct(Product product) async {
    try {
      CollectionReference products = _db.collection('products');

      await products.add({
        'name': product.name,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'rating': product.rating,
        'isOnSale': product.isOnSale,
      });
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<Product> fetchProductById(String productId) async {
    try {
      // Reference to the product document by ID
      DocumentSnapshot docSnapshot = await _db.collection('products').doc(productId).get();

      if (docSnapshot.exists) {
        var data = docSnapshot.data() as Map<String, dynamic>;
        return Product(
          id: docSnapshot.id,
          name: data['name'],
          price: data['price'],
          imageUrl: data['imageUrl'],
          rating: data['rating'],
          isOnSale: data['isOnSale'],
        );
      } else {
        throw Exception('Product not found');
      }
    } catch (e) {
      print('Error fetching product: $e');
      throw e;
    }
  }

  // Fetch products from Firestore
  Future<List<Product>> fetchProducts() async {
    try {
      // Reference to the products collection
      CollectionReference products = _db.collection('products');

      // Get the product documents
      QuerySnapshot querySnapshot = await products.get();

      // Map the query results to a list of products
      List<Product> productList = querySnapshot.docs.map((doc) {
        return Product(
          id: doc.id,
          name: doc['name'],
          price: doc['price'],
          imageUrl: doc['imageUrl'],
          rating: doc['rating'],
          isOnSale: doc['isOnSale'],
        );
      }).toList();

      return productList;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  // Update a product
  Future<void> updateProduct(Product product) async {
    try {
      // Reference to the product document
      DocumentReference productRef = _db.collection('products').doc(product.id);

      // Update the product document
      await productRef.update({
        'name': product.name,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'rating': product.rating,
        'isOnSale': product.isOnSale,
      });
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  // Delete a product
  Future<void> deleteProduct(String productId) async {
    try {
      // Reference to the product document
      DocumentReference productRef = _db.collection('products').doc(productId);

      // Delete the product document
      await productRef.delete();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
}
