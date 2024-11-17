import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab10/models/product_bloc.dart';
import 'package:lab10/models/product_event.dart';
import 'package:lab10/models/product_state.dart';
import 'package:lab10/screens/details_page.dart';
import 'package:lab10/widgets/search_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void showDetailScreen(BuildContext context, int productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailsPage(productId: productId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dispatching LoadProductsEvent to load the products
    context.read<ProductBloc>().add(LoadProductsEvent());

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
            size: 25,
          ),
        ),
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
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductError) {
            return const Center(child: Text('Error loading products'));
          } else if (state is ProductLoaded) {
            return SingleChildScrollView(
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
                          children: state.products
                              .map((product) => InkWell(
                            onTap: () {
                              showDetailScreen(context, product.id);
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
                                          child: Image.asset(product.image),
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
                                            BorderRadius.circular(
                                                10),
                                            color: Colors.orange,
                                          ),
                                          child: const Text('SALE'),
                                        )
                                            : Container(),
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
                                                    fontWeight:
                                                    FontWeight.bold,
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
                                                const SizedBox(width: 30),
                                                GestureDetector(
                                                  onTap: () {
                                                    context.read<ProductBloc>().add(ToggleFavoriteEvent(product.id));
                                                  },
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: product.isFavorite
                                                        ? Colors.red
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(product.name,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 2, 55, 98),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ],
                            ),
                          )).toList(),
                        )
                    ),
              ]
            )
            );
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
