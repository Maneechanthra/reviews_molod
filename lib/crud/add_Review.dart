import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reviews_molod/api/api_category_list.dart';
import 'package:reviews_molod/api/api_catgory.dart';
import 'package:reviews_molod/catgoly/catgoly.dart';
import 'package:http/http.dart' as http;
import 'package:reviews_molod/views/home.dart';

class AddReviewPage extends StatefulWidget {
  final int user_id;
  final String userName;
  final String email;
  const AddReviewPage(this.user_id, this.userName, this.email, {Key? key})
      : super(key: key);

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  late Future<ApiResponsePost> futureApiResponse;

  final _AddReviewsForm = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  int selectedCategoryIndex = 0;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  //select img -----------------------------------------------
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
  //--------------------------------------------------------

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    bodyController.dispose();
  }

  @override
  void initState() {
    super.initState();
    // futureApiResponse = fetchApiPost();
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
          filename: 'image$i.png+',
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

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Form(
          key: _AddReviewsForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 100,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: Color.fromARGB(255, 177, 144, 243),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(115, 139, 139, 139),
                            offset: Offset(0.0, 6.0),
                            blurRadius: 6.0),
                      ]),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40.0, right: 40, top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(100)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_back,
                                color: Color.fromARGB(255, 7, 7, 7),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "เพิ่มรีวิว",
                          style: GoogleFonts.prompt(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(100)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.home,
                                color: Color.fromARGB(255, 7, 7, 7),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                "assets/img/review_img.png",
                width: 200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: titleController, // Add this line
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'ชื่อเรื่อง...'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: bodyController, // Add this line
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'รายละเอียดรีวิว'),
                  maxLines: 3,
                  maxLength: 400,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(400),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "หมวดหมู่ : ",
                      style: GoogleFonts.prompt(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 124, 124, 124)),
                    ),
                    DropdownButtonFormField<int>(
                      value: selectedCategoryIndex, // Add this line
                      items: categories.asMap().entries.map((entry) {
                        return DropdownMenuItem<int>(
                          value: entry.key,
                          child: Text(
                            entry.value.title,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        );
                      }).toList(),
                      onChanged: (int? index) {
                        setState(() {
                          selectedCategoryIndex = index ?? 0;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Icon(Icons.add_a_photo_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "เพิ่มรูปภาพ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 124, 124, 124),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    if (index < imageFileList.length) {
                      return Stack(
                        children: [
                          Image.file(
                            File(imageFileList[index].path),
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      imageFileList.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (imageFileList.length < 3) {
                      return IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          selectedImages();
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                  itemCount: imageFileList.length < 3
                      ? imageFileList.length + 1
                      : imageFileList.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: 400,
                  child: FilledButton(
                    onPressed: () async {
                      if (_AddReviewsForm.currentState!.validate()) {
                        print("Add Review Prograss");
                        CategoryModel res = await category();
                        print("Add review Success");
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(
                                widget.user_id, widget.email, widget.userName),
                          ),
                        );
                        displayDialog(context, "สำเร็จ", "บันทึกข้อมูลสำเร็จ!");
                      } else {
                        displayDialog(
                            context, "ไม่สำเร็จ", "บันทึกข้อมูลไม่สำเร็จ!");
                      }
                    },
                    child: const Text(
                      "บันทึกข้อมูล",
                      style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
