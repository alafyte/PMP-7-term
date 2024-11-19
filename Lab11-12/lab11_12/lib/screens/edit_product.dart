import 'package:flutter/material.dart';
import 'package:lab11_12/logic/product.dart';
import 'package:lab11_12/logic/product_service.dart';
import 'package:lab11_12/screens/details_page.dart';
import 'package:lab11_12/screens/home_page.dart';

class EditProductPage extends StatefulWidget {
  final String productId;

  const EditProductPage({super.key, required this.productId});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late Future<Product> _product;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _imageUrlController;
  final ValueNotifier<bool> _isOnSaleNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _product = ProductService().fetchProductById(widget.productId);
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _imageUrlController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteProduct,
          ),
        ],
      ),
      body: FutureBuilder<Product>(
        future: _product,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Product not found.'));
          } else {
            final product = snapshot.data!;
            _nameController.text = product.name;
            _priceController.text = product.price.toString();
            _imageUrlController.text = product.imageUrl;
            _isOnSaleNotifier.value = product.isOnSale;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Product Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a product name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _imageUrlController,
                      decoration: const InputDecoration(labelText: 'Image URL'),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isOnSaleNotifier,
                      builder: (context, isOnSale, child) {
                        return SwitchListTile(
                          title: const Text('On Sale'),
                          value: isOnSale,
                          onChanged: (value) {
                            _isOnSaleNotifier.value = value; // Update the notifier value
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _saveProduct,
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _saveProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        Product updatedProduct = Product(
          id: widget.productId,
          name: _nameController.text,
          price: double.parse(_priceController.text),
          imageUrl: _imageUrlController.text,
          rating: 5, // Set a default or current rating
          isOnSale: _isOnSaleNotifier.value,
        );

        await ProductService().updateProduct(updatedProduct);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(productId: widget.productId),
          ),
        );
// Go back to the previous page
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error updating product: $e'),
        ));
      }
    }
  }

  Future<void> _deleteProduct() async {
    try {
      await ProductService().deleteProduct(widget.productId);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error deleting product: $e'),
      ));
    }
  }
}
