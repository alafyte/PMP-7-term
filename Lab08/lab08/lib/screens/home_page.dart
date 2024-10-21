import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab08/screens/add_product.dart';
import 'package:lab08/user.dart';
import 'package:lab08/screens/users_screen.dart';
import 'package:hive/hive.dart';
import 'package:lab08/widgets/search_widget.dart';
import 'cart_page.dart';
import 'details_page.dart';
import 'package:lab08/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? currentUser;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    loadCurrentUser();
    loadProducts();
  }

  void loadCurrentUser() async {
    var box = await Hive.openBox<User>('users');
    if (box.isNotEmpty) {
      setState(() {
        currentUser = box.getAt(0);
      });
    } else {
      setState(() {
        currentUser = null;
      });
    }
  }

  void loadProducts() async {
    var box = await Hive.openBox<Product>('products');
    setState(() {
      products = box.values.toList();
    });
  }

  showDetailScreen(int productId, String productName, String productPrice) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailsPage(id: productId, currentUser: currentUser),
      ),
    ).then((_) {
      loadProducts();
    });
  }

  void addProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddProductPage(),
      ),
    ).then((_) {
      loadProducts();
    });
  }

  void switchUser() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserListPage(
          onUserSelected: (User user) {
            setState(() {
              currentUser = user;
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => {},
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 25,
              ),
            ),
            Image.asset(
              'src/assets/nike.png',
              width: 45,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CartPage(userName: currentUser?.name ?? ''),
                  ),
                );
              },
              icon: const Icon(
                Icons.local_mall_outlined,
                color: Color.fromARGB(214, 15, 15, 15),
                size: 28,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            const SearchWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                onPressed: switchUser,
                child: Text(
                  'Current User: ${currentUser?.name ?? "Unknown"}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (currentUser?.role.name == 'admin')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  onPressed: addProduct,
                  child: const Text(
                    'Add Product',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 260,
              child: Image.asset('src/assets/big_shoes02.png'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Nike',
                style: TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 2, 55, 98),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Collection',
                style: TextStyle(
                  fontSize: 38,
                  color: Color.fromARGB(187, 72, 72, 72),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'On Trend',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 2, 55, 98),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('1/10',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      Container(
                        width: 135,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 22,
                              height: 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 2, 55, 98),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: products.map((product) {
                  return InkWell(
                    onTap: () {
                      showDetailScreen(product.id, product.productName, product.price.toString());
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                          child: Stack(
                            children: [
                              Positioned(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    left: 20,
                                    top: 20,
                                  ),
                                  height: 200,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 2, 55, 98),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 50,
                                left: 30,
                                child: SizedBox(
                                  width: 140,
                                  child: Image.asset(
                                    'src/assets/big_shoes.png',
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 25,
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          '\$',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          product.price.toString(),
                                          style: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 50),
                                        const Icon(Icons.favorite, color: Colors.red)
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            product.productName,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 2, 55, 98),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
