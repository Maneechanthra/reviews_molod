import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reviews_molod/api/api_editPost.dart';
import 'package:reviews_molod/catgoly/catgoly.dart';
import 'package:reviews_molod/class_list/listmenu.dart';
import 'package:http/http.dart' as http;

class EditReview extends StatefulWidget {
  final int user_id;
  final int post_id;
  const EditReview(this.user_id, this.post_id, {Key? key}) : super(key: key);

  @override
  State<EditReview> createState() => _EditReviewState();
}

class _EditReviewState extends State<EditReview> {
  DateTime? selectedDate;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  late Future<EditPost> futureEditPost;
  final _editReviwewForm = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  List<String> categoryList = [];
  String selectedCategory = '';

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    bodyController.dispose();
  }

  Future<EditPost> fetchEditPost(int postId) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/post/$postId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
      },
    );

    print(postId);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final post = EditPost.fromJson(data);
      titleController.text = post.title;
      bodyController.text = post.body;
      selectedCategory = post.category.toString();

      return post;
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  void fetchCategoriesFromAPI() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/categories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
          'connection': 'keep-alive',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          categoryList =
              jsonData.map((json) => json['title'].toString()).toList();
        });
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    futureEditPost = fetchEditPost(widget.post_id);
    fetchCategoriesFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 7, 119, 113),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 119, 113),
        title: Center(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Form(
                      key: _editReviwewForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "แก้ไขรีวิว",
                            style: GoogleFonts.prompt(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextFormField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              labelText: "ชื่อสถานที่",
                              hintText: 'กรอกชื่อสถานที่',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: bodyController,
                            decoration: const InputDecoration(
                              labelText: "รายละเอียด",
                              hintText: 'กรอกรายละเอียดสถานที่ท่องเที่ยว...',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "ประเภท",
                            style: GoogleFonts.prompt(),
                          ),
                          DropdownButtonFormField<String>(
                            value: categoryList.contains(selectedCategory)
                                ? selectedCategory
                                : null,
                            items: categoryList.map((category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                selectedCategory = value ?? "";
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: SizedBox(
                                width: 500,
                                height: 40,
                                child: FilledButton(
                                    onPressed: () {},
                                    child: const Text("Save"))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
