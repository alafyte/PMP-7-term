import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lab08/cart.dart';
import 'package:lab08/product.dart';
import 'package:lab08/role.dart';
import 'package:lab08/screens/home_page.dart';
import 'package:lab08/user.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RoleAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CartItemAdapter());

  await Hive.openBox<Product>('products');
  await Hive.openBox<User>('users');
  await Hive.openBox<CartItem>('cart');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
