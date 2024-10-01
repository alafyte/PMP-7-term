import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab04_05/screens/details_page.dart';
import 'package:lab04_05/screens/home_page.dart';

void main() {
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
      routes: {
        "detailsPage": (context) => const DetailsPage(),
      },
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
