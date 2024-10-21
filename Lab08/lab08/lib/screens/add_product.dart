import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lab08/product.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String? _productName;
  double? _productPrice;

  Future<int> getLastProductId() async {
    var box = await Hive.openBox<Product>('products');

    List<Product> products = box.values.toList();

    int lastId = 0;
    for (var product in products) {
      if (product.id > lastId) {
        lastId = product.id;
      }
    }

    return lastId;
  }


  void _saveProduct() async {
    final id = await getLastProductId();

    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final newProduct = Product(id + 1,
        _productName!,
        _productPrice!
      );

      var box = Hive.box<Product>('products');
      await box.put(newProduct.id, newProduct);

      Navigator.pop(context);
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
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Product name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter product name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _productName = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Product price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter product price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Enter correct price';
                  }
                  return null;
                },
                onSaved: (value) {
                  _productPrice = double.tryParse(value!);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
