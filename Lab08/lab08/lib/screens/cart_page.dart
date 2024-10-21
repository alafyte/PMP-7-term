import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lab08/cart.dart';
import 'package:lab08/product.dart'; // Import your Product model

class CartPage extends StatefulWidget {
  final String userName;

  const CartPage({super.key, required this.userName});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItems = [];
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
    loadCartItems();
  }

  void loadProducts() async {
    final box = Hive.box<Product>('products');
    setState(() {
      products = box.values.toList();
    });
  }

  void loadCartItems() async {
    final box = Hive.box<CartItem>('cart');
    setState(() {
      cartItems = box.values.where((item) => item.userName == widget.userName).toList();
    });
  }

  void removeItemFromCart(CartItem cartItem) async {
    final box = Hive.box<CartItem>('cart');
    await box.delete(cartItem.id);

    loadCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart for ${widget.userName}'),
      ),
      body: cartItems.isEmpty
          ? const Center(
        child: Text(
          'Your cart is empty',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];
          final product = products.firstWhere(
                (product) => product.id == cartItem.productId,
            orElse: () => Product(-1, 'Deleted Product. ', 0),
          );

          return ListTile(
            title: Text('Product Name: ${product.productName}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                  removeItemFromCart(cartItem);
              },
            ),
          );
        },
      ),
    );
  }

}
