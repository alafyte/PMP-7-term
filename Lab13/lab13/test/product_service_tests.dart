import 'package:flutter_test/flutter_test.dart';
import 'package:lab11_12/logic/product.dart';
import 'firebase_mock.dart';
import 'package:lab11_12/logic/product_utils.dart';

void main() {
  late MockFirebaseFirestore firebaseFirestoreMock;
  late MockCollectionReference mockCollectionReference;
  late MockDocumentReference mockDocumentReference;
  late ProductService productService;

  final Product testProduct = Product(
    id: '1',
    name: 'Test Product',
    price: 99.99,
    imageUrl: 'http://example.com/image.jpg',
    rating: 4.5,
    isOnSale: true,
  );

  setUp(() {
    firebaseFirestoreMock = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    productService = ProductService();
  });

  test('should instantiate firebase', () {
    expect(firebaseFirestoreMock, isNotNull);
    expect(mockCollectionReference, isNotNull);
    expect(mockDocumentReference, isNotNull);
  });

  test('should add a product', () {
    productService.addProduct(testProduct);
    final products = productService.getAllProducts();
    expect(products.length, 1);
    expect(products.first.name, 'Test Product');
  });

  test('should fetch a product by ID', () {
    productService.addProduct(testProduct);
    final product = productService.getProductById('1');
    expect(product, isNotNull);
    expect(product?.name, 'Test Product');
  });

  test('should update a product', () {
    productService.addProduct(testProduct);
    final updatedProduct = Product(
      id: '1',
      name: 'Updated Product',
      price: 89.99,
      imageUrl: 'http://example.com/new_image.jpg',
      rating: 4.8,
      isOnSale: false,
    );
    productService.updateProduct(updatedProduct);

    final product = productService.getProductById('1');
    expect(product?.name, 'Updated Product');
    expect(product?.price, 89.99);
    expect(product?.imageUrl, 'http://example.com/new_image.jpg');
  });

  test('should delete a product by ID', () {
    productService.addProduct(testProduct);
    productService.deleteProduct('1');

    final products = productService.getAllProducts();
    expect(products.isEmpty, true);
  });

  test('should return null for non-existent product', () {
    final product = productService.getProductById('non-existent-id');
    expect(product, isNull);
  });
}
