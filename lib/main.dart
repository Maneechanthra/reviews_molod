import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/crud/add_Review.dart';

import 'package:reviews_molod/views/detail_review.dart';
import 'package:reviews_molod/views/home.dart';
import 'package:reviews_molod/views/index.dart';
import 'package:reviews_molod/views/login.dart';
// import 'package:reviews_molod/views/food.dart';
// import 'package:reviews_molod/views/index.dart';
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
    MaterialColor primarySwatchColor =
        const MaterialColor(0xFFBDAEFF, <int, Color>{
      50: Color(0xFFBDAEFF),
      100: Color(0xFFBDAEFF),
      200: Color(0xFFBDAEFF),
      300: Color(0xFFBDAEFF),
      400: Color(0xFFBDAEFF),
      500: Color(0xFFBDAEFF), // The primary color
      600: Color(0xFFBDAEFF),
      700: Color(0xFFBDAEFF),
      800: Color(0xFFBDAEFF),
      900: Color(0xFFBDAEFF),
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reviews Molod',
      theme: ThemeData(
        primarySwatch: primarySwatchColor,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.kanitTextTheme(Theme.of(context).textTheme),
        // Add more theme settings as needed
      ),
      home: const Index(),
    );
  }
}
