import 'dart:convert';
import 'dart:io';
// import 'dart:html';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reviews_molod/api/api_catgory.dart';
import 'package:reviews_molod/api/api_register.dart';
import 'package:reviews_molod/catgoly/catgoly.dart';
import 'package:reviews_molod/class_list/listmenu.dart';
import 'package:http/http.dart' as http;
import 'package:reviews_molod/views/home.dart';
import 'package:reviews_molod/views/tavel.dart';

class AddReviews extends StatefulWidget {
  final int user_id;
  final String userName;
  final String email;
  const AddReviews(this.user_id, this.userName, this.email, {Key? key})
      : super(key: key);

  @override
  State<AddReviews> createState() => _AddReviewsState();
}

class _AddReviewsState extends State<AddReviews> {
  late Future<ApiResponsePost> futureApiResponse;
  final _AddReviewsForm = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  int selectedCategoryIndex = 0;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  void selectedImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();

    for (XFile image in selectedImages) {
      print("Selected Image: ${image.path}");
    }

    if (imageFileList.length + selectedImages.length <= 3) {
      setState(() {
        imageFileList.addAll(selectedImages);
      });
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Exceeded Maximum Image Count"),
            content: Text("You can select up to 3 images"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    bodyController.dispose();
  }

  @override
  void initState() {
    super.initState();
    futureApiResponse = fetchApiPost();
    fetchCategoriesFromAPI();
  }

  Future<CategoryModel> category() async {
    if (selectedCategoryIndex >= 0 &&
        selectedCategoryIndex < categories.length) {
      final title = titleController.text;
      final body = bodyController.text;
      final userId = widget.user_id.toString(); // Convert user_id to a String
      final categoryId = categories[selectedCategoryIndex].id;

      final request = http.MultipartRequest(
          'POST', Uri.parse('http://10.0.2.2:8000/api/post/insert'));

      request.fields['title'] = title;
      request.fields['body'] = body;
      request.fields['user_id'] = userId.toString();
      request.fields['category'] = categoryId.toString();

      for (int i = 0; i < imageFileList.length; i++) {
        File imageFile = File(imageFileList[i].path);
        String fieldName = 'img_content_${i + 1}';
        request.files.add(http.MultipartFile(
          fieldName,
          imageFile.readAsBytes().asStream(),
          imageFile.lengthSync(),
          filename: 'image$i.jpg',
        ));
      }

      if (imageFileList.length >= 1 && imageFileList.length <= 3) {
        final response = await request.send();

        print(response.statusCode);

        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseJson = await response.stream.bytesToString();
          final Map<String, dynamic> data = jsonDecode(responseJson);
          return CategoryModel.fromJson(data);
        } else {
          throw Exception("Failed to Add Reviews");
        }
      } else {
        throw Exception("You must select 1 to 3 images");
      }
    } else {
      throw Exception('Invalid selectedCategoryIndex');
    }
  }

  List<CategoriesModel> categories = [];

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
          categories =
              jsonData.map((json) => CategoriesModel.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 119, 113),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 119, 113),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 20.0),
            //   child: Image.asset(
            //     "assets/logo.png",
            //     width: 150,
            //   ),
            // ),
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
                      key: _AddReviewsForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "เพิ่มรีวิว",
                            style: GoogleFonts.prompt(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          TextFormField(
                            controller: titleController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: "ชื่อสถานที่",
                              hintText: 'กรอกชื่อสถานที่',
                            ),
                            onChanged: (String value) {},
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please enter title'
                                  : null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: bodyController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: "รายละเอียด",
                              hintText: 'กรอกรายละเอียดสถานที่ท่องเที่ยว...',
                            ),
                            maxLines: 3,
                            maxLength: 200,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(200),
                            ],
                            onChanged: (String value) {},
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please enter body'
                                  : null;
                            },
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
                          DropdownButtonFormField<int>(
                            items: categories.asMap().entries.map((entry) {
                              return DropdownMenuItem<int>(
                                value: entry.key,
                                child: Text(entry.value.title),
                              );
                            }).toList(),
                            onChanged: (int? index) {
                              setState(() {
                                selectedCategoryIndex = index ?? 0;
                              });
                            },
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (context, index) {
                                if (index < imageFileList.length) {
                                  return Image.file(
                                    File(imageFileList[index].path),
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      selectedImages();
                                    },
                                  );
                                }
                              },
                              itemCount: imageFileList.length + 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: SizedBox(
                                width: 500,
                                height: 40,
                                child: FilledButton(
                                    onPressed: () async {
                                      if (_AddReviewsForm.currentState!
                                          .validate()) {
                                        print("Add Review Prograss");
                                        CategoryModel res = await category();
                                        print("Add review Success");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Home(
                                                widget.user_id,
                                                widget.email,
                                                widget.userName),
                                          ),
                                        );
                                      }
                                    },
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
