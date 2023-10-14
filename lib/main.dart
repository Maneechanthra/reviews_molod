import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/views/home.dart';
// import 'package:reviews_molod/views/food.dart';
import 'package:reviews_molod/views/index.dart';
// import 'package:reviews_molod/views/index.dart';
// import 'package:reviews_molod/views/login.dart';
// import 'package:reviews_molod/views/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reviews Malod',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 1, 90, 83)),
        useMaterial3: true,
        textTheme: GoogleFonts.promptTextTheme(Theme.of(context).textTheme),
      ),
      home: const Home(),
    );
  }
}
