import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab11_12/logic/product.dart';
import 'package:lab11_12/screens/add_product_page.dart';
import 'package:lab11_12/screens/profile_page.dart';
import '../widgets/search_widget.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<List<Product>> fetchProducts() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    return snapshot.docs.map((doc) => Product.fromDocument(doc)).toList();
  }

  showDetailScreen(String productId) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => DetailsPage(productId: productId)));
  }

  @override
  void initState() {
    super.initState();
    _initializeFCM();
  }

  Future<void> _initializeFCM() async {
    NotificationSettings settings = await _messaging.requestPermission();
    print('User granted permission: ${settings.authorizationStatus}');

    String? token = await _messaging.getToken();
    print('FCM Token: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in foreground!');
      if (message.notification != null) {
        print('Notification: ${message.notification!.title}');
        print('Body: ${message.notification!.body}');
      }
    });

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
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddProductPage()),
                );
              },
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
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              icon: const Icon(
                Icons.account_circle,
                color: Colors.black,
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Using FutureBuilder to fetch products asynchronously
            FutureBuilder<List<Product>>(
              future: fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products available.'));
                }

                var productList = snapshot.data!;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var product in productList)
                        InkWell(
                          onTap: () {
                            showDetailScreen(product.id);
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
                                          color: const Color.fromARGB(
                                              255, 2, 55, 98),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 50,
                                      left: 30,
                                      child: SizedBox(
                                        width: 140,
                                        child: Image.network(
                                          product.imageUrl,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 40,
                                      left: 10,
                                      child: product.isOnSale
                                          ? Container(
                                              height: 25,
                                              width: 60,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.orange,
                                              ),
                                              child: const Text('SALE'),
                                            )
                                          : Container(),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 45,
                                      child: Row(
                                        children: [
                                          const Text(
                                            '\$',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            '${product.price}',
                                            style: const TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  product.name,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 2, 55, 98),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
