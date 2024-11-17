import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab09/models/product_provider.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  final int productId;

  const DetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context)
        .products
        .firstWhere((product) => product.id == productId);

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
                    if (product.isOnSale)
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
                    if (!product.isOnSale)
                      Container(
                        height: 22,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        width: 50,
                      ),
                    IconButton(
                        onPressed: () {
                          // Toggle favorite status
                          context
                              .read<ProductProvider>()
                              .toggleFavorite(product.id);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: product.isFavorite ? Colors.red : Colors.grey,
                          size: 30,
                        )),
                  ],
                ),
              ),
              SizedBox(
                child: Image.asset(product.image),
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
                  Text(
                    product.name,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 2, 55, 98),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                      child: Row(
                    children: [
                      for (int i = 0; i < 5; i++)
                        Icon(
                          Icons.star,
                          size: 24,
                          color: i < product.rating
                              ? const Color.fromARGB(255, 248, 172, 7)
                              : Colors.grey.withOpacity(0.5),
                        )
                    ],
                  ))
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'The ${product.name} Shoe borrows design lines from the heritage runners like the Nike React Technology.',
                style: const TextStyle(
                  height: 1.6,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color.fromARGB(185, 158, 158, 158),
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
                            '${product.price}',
                            style: const TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 2, 55, 98),
                            ),
                          ),
                        ],
                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
