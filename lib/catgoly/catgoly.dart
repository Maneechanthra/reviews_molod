import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:reviews_molod/views/book.dart';
import 'package:reviews_molod/views/food.dart';
import 'package:reviews_molod/views/movie.dart';
import 'package:reviews_molod/views/restaurant.dart';
import 'package:reviews_molod/views/tavel.dart';

class Catgoly extends StatefulWidget {
  const Catgoly({Key? key}) : super(key: key);

  @override
  _CatgolyState createState() => _CatgolyState();
}

class CategoriesModel {
  final int id;
  final String title;

  CategoriesModel({
    required this.id,
    required this.title,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      title: json['title'],
    );
  }
}

class _CatgolyState extends State<Catgoly> {
  late Future<List<CategoriesModel>> futureCategories;

  List<CategoriesModel> categories = [];

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  Future<List<CategoriesModel>> fetchCategories() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/categories'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "*/*",
        'connection': 'keep-alive',
      },
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body) as List<dynamic>;
      return data.map((json) => CategoriesModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
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
                            builder: (context) => Tavel(category.id),
                          ),
                        );
                      } else if (category.title == "อาหาร/เครื่องดื่ม") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Food(category.id),
                          ),
                        );
                      } else if (category.title == "ภาพยนต์") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Movie(category.id),
                          ),
                        );
                      } else if (category.title == "ร้านอาหาร") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Restaurant(category.id),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Book(category.id),
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
