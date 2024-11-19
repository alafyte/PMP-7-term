import 'package:flutter/material.dart';
import 'package:lab11_12/logic/product.dart';
import 'package:lab11_12/logic/product_service.dart';
import 'package:lab11_12/screens/home_page.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _productService = ProductService();

  String _name = '';
  double _price = 0.0;
  String _imageUrl = '';
  double _rating = 0.0;
  bool _isOnSale = false;

  // Function to handle form submission
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        id: '',
        name: _name,
        price: _price,
        imageUrl: _imageUrl,
        rating: _rating,
        isOnSale: _isOnSale,
      );

      // Add the product to Firestore
      await _productService.addProduct(newProduct);

      // Show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully!')),
      );

      // Clear the form fields
      _formKey.currentState!.reset();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Product Name
              TextFormField(
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
                onChanged: (value) {
                  _name = value;
                },
              ),

              // Product Price
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price <= 0) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
                onChanged: (value) {
                  _price = double.tryParse(value) ?? 0.0;
                },
              ),

              // Product Image URL
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
                onChanged: (value) {
                  _imageUrl = value;
                },
              ),

              // Product Rating
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rating';
                  }
                  final rating = double.tryParse(value);
                  if (rating == null || rating < 0 || rating > 5) {
                    return 'Please enter a rating between 0 and 5';
                  }
                  return null;
                },
                onChanged: (value) {
                  _rating = double.tryParse(value) ?? 0.0;
                },
              ),

              // Is on Sale
              SwitchListTile(
                title: const Text('Is on Sale'),
                value: _isOnSale,
                onChanged: (bool value) {
                  setState(() {
                    _isOnSale = value;
                  });
                },
              ),

              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Add Product'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
