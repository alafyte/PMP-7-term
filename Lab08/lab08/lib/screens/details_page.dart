import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lab08/cart.dart';
import 'package:lab08/product.dart';
import 'package:lab08/user.dart';

class DetailsPage extends StatefulWidget {
  final int id;
  final User? currentUser;

  const DetailsPage({super.key, required this.id, required this.currentUser});

  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  final PageController _pageController = PageController();
  late TextEditingController nameController;
  late TextEditingController priceController;
  late Product product;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _loadProduct() {
    final box = Hive.box<Product>('products');

    product = box.values.firstWhere((product) => product.id == widget.id);

    nameController = TextEditingController(text: product.productName);
    priceController = TextEditingController(text: product.price.toString());
    setState(() {});
  }

  int getLastCartId() {
    var box = Hive.box<CartItem>('cart');

    List<CartItem> cart = box.values.toList();

    int lastId = 0;
    for (var cartItem in cart) {
      if (cartItem.id > lastId) {
        lastId = cartItem.id;
      }
    }
    return lastId;
  }

  void _deleteProduct() {
    final box = Hive.box<Product>('products');
    box.delete(product.id);
    Navigator.pop(context);
  }

  void _editProduct() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newName = product.productName;
        double newPrice = product.price;

        return AlertDialog(
          title: const Text('Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                onChanged: (value) {
                  newName = value;
                },
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: priceController,
                onChanged: (value) {
                  newPrice = double.tryParse(value) ?? product.price;
                },
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  product.productName = newName;
                  product.price = newPrice;
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        title: Row(
          children: [
            const Spacer(),
            Image.asset(
              'src/assets/nike.png',
              width: 45,
            ),
            const Spacer(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 22,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 232, 162, 9),
                      ),
                      child: const Text('SALE',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: PageView(
                  controller: _pageController,
                  children: [
                    SizedBox(
                      child: Image.asset(
                        'src/assets/model201.png',
                        // Use id for dynamic image
                      ),
                    ),
                    SizedBox(
                      child: Image.asset(
                        'src/assets/model101.png',
                      ),
                    ),
                    SizedBox(
                      child: Image.asset(
                        'src/assets/model201.png',
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '360',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.pinch,
                        size: 15,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 7,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5)))
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.productName,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 2, 55, 98),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                      child: Row(
                    children: [
                      for (int i = 0; i < 5; i++)
                        Icon(
                          Icons.star,
                          size: 24,
                          color: i != 4
                              ? const Color.fromARGB(255, 248, 172, 7)
                              : Colors.grey.withOpacity(0.5),
                        )
                    ],
                  ))
                ],
              ),
              if (widget.currentUser?.role.name == 'admin')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: _editProduct,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: _deleteProduct,
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              Text(
                'The ${product.productName} Shoe borrows design lines from the heritage runners like the Nike React Technology.',
                style: const TextStyle(
                  height: 1.6,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color.fromARGB(185, 158, 158, 158),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Size',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 0, 35, 63),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < 5; i++)
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        alignment: Alignment.center,
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: i == 3
                              ? const Color.fromARGB(255, 2, 55, 98)
                              : Colors.transparent,
                          border: Border.all(
                              width: 2,
                              color: i != 3
                                  ? const Color.fromARGB(255, 2, 55, 98)
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                            '${i == 0 ? 5 : i == 1 ? 5.5 : i == 2 ? 6 : i == 3 ? 6.5 : 7}',
                            style: TextStyle(
                                fontSize: 20,
                                color: i == 3
                                    ? const Color.fromARGB(192, 248, 182, 40)
                                    : const Color.fromARGB(255, 2, 55, 98))),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      height: 7,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Reviews 39',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 2, 55, 98),
                          ),
                        ),
                        SizedBox(
                          width: 160,
                          child: Stack(
                            children: [
                              for (int i = 0; i <= 3; i++)
                                Positioned(
                                  left: i != 0 ? i * 38 : null,
                                  child: CircleAvatar(
                                      radius: 26,
                                      child: Image.asset(
                                        'src/assets/avatar0$i.png',
                                      )),
                                ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '\$',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.price.toString(),
                            style: const TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 2, 55, 98),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 2, 55, 98),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (widget.currentUser != null) {
                            final box = Hive.box<CartItem>('cart');
                            final exists = box.values.any((item) =>
                            item.productId == product.id && item.userName == widget.currentUser!.name);

                            if (!exists) {
                              final id = getLastCartId();
                              final cartItem = CartItem(id + 1, product.id, widget.currentUser!.name);

                              box.put(cartItem.id, cartItem);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Product added to cart')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('This product is already in your cart')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Please log in to add products to cart')),
                            );
                          }
                        },
                        child: const Text(
                          '+ Add To Cart',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(192, 248, 182, 40),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
