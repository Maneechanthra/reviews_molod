import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:reviews_molod/api/api_category_list.dart';

import 'package:reviews_molod/views/detail_category_page.dart';

class Catgoly extends StatefulWidget {
  const Catgoly({Key? key}) : super(key: key);

  @override
  _CatgolyState createState() => _CatgolyState();
}

class _CatgolyState extends State<Catgoly> {
  late Future<List<CategoriesModel>> futureCategories;

  List<CategoriesModel> categories = [];

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoriesModel>>(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final categories = snapshot.data!;

          return GestureDetector(
            child: SizedBox(
              height: 85,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      if (category.title == "สถานที่ท่องเที่ยว") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailCategoryPage(category.id),
                          ),
                        );
                      } else if (category.title == "อาหาร/เครื่องดื่ม") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailCategoryPage(category.id),
                          ),
                        );
                      } else if (category.title == "ภาพยนต์") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailCategoryPage(category.id),
                          ),
                        );
                      } else if (category.title == "ร้านอาหาร") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailCategoryPage(category.id),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailCategoryPage(category.id),
                          ),
                        );
                      }
                    },
                    child: Card(
                      elevation: 8.0, // No elevation (no shadow)
                      shadowColor: Color.fromARGB(255, 214, 233, 253),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15), // No border radius
                      ),
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Column(
                            children: [
                              if (category.title == "หนังสือ")
                                Image.asset(
                                  "assets/icons/ratings.png",
                                  width: 25,
                                ),
                              if (category.title == "อาหาร/เครื่องดื่ม")
                                Image.asset(
                                  "assets/icons/iftar.png",
                                  width: 25,
                                ),
                              if (category.title == "สถานที่ท่องเที่ยว")
                                Image.asset(
                                  "assets/icons/airplane.png",
                                  width: 25,
                                ),
                              if (category.title == "ร้านอาหาร")
                                Image.asset(
                                  "assets/icons/restaurant.png",
                                  width: 25,
                                ),
                              if (category.title == "ภาพยนต์")
                                Image.asset(
                                  "assets/icons/movie.png",
                                  width: 25,
                                ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                category.title,
                                style: GoogleFonts.prompt(),
                              ),
                            ],
                          )),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Padding(padding: EdgeInsets.only(right: 10)),
                itemCount: categories.length,
              ),
            ),
          );
        } else {
          return Text('No data available.');
        }
      },
    );
  }
}
