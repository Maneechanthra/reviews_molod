import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reviews_molod/api/api_catgory.dart';
import 'package:reviews_molod/api/api_editPost.dart';
// import 'package:reviews_molod/catgoly/catgoly.dart';
import 'package:reviews_molod/api/api_categories.dart';
import 'package:http/http.dart' as http;
import 'package:reviews_molod/views/home.dart';
import 'package:reviews_molod/profile/profile.dart';

class EditReviewPage extends StatefulWidget {
  final int user_id;
  final int post_id;
  // final String email, name;
  // this.name, this.email,
  const EditReviewPage(this.user_id, this.post_id, {Key? key})
      : super(key: key);

  @override
  State<EditReviewPage> createState() => _EditReviewPageState();
}

class _EditReviewPageState extends State<EditReviewPage> {
  // DateTime? selectedDate;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  List<String> userSavedImageURLs = [];

  late Future<EditPost> futureEditPost;
  final _editReviewForm = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  int selectedCategoryIndex = 1;

  List<CategoriesModel> categories = [];

  List<String> categoryList = [];
  String selectedCategory = '';

  String selectedCategoryName = "";

  List<String> imageUrls = [];

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    bodyController.dispose();
  }

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

  Future<EditPost> fetchEditPost(int postId) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/post/$postId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final post = EditPost.fromJson(data);
      titleController.text = post.title;
      bodyController.text = post.body;
      selectedCategoryIndex = post.category;
      print("id =>>");
      print(selectedCategoryIndex);

      if (selectedCategoryIndex == 1) {
        selectedCategoryName = "หนังสือ";
      } else if (selectedCategoryIndex == 2) {
        selectedCategoryName = "สถานที่ท่องเที่ยว";
      } else if (selectedCategoryIndex == 3) {
        selectedCategoryName = "อาหาร/เครื่องดื่ม";
      } else if (selectedCategoryIndex == 4) {
        selectedCategoryName = "ร้านอาหาร";
      } else if (selectedCategoryIndex == 5) {
        selectedCategoryName = "ภาพยนต์";
      }

      List<String> imageFileList = [
        post.imgContent1,
        post.imgContent2,
        post.imgContent3,
      ];

      // Create a list of image URLs based on the image file names
      imageUrls = imageFileList
          .map((imageName) =>
              'http://10.0.2.2:8000/api/storage/img_content/$imageName')
          .toList();

      print(imageUrls);

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
          categories =
              jsonData.map((json) => CategoriesModel.fromJson(json)).toList();
          categoryList = categories.map((category) => category.title).toList();
          print(categoryList);
        });
      } else {
        throw Exception('Failed to load data from API: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Future<EditPost> updatePost() async {
  //   final body = {
  //     'id': widget.post_id,
  //     'title': titleController.text,
  //     'body': bodyController.text,
  //     'category': selectedCategoryIndex,
  //     'user_id': widget.user_id
  //   };
  //   print(selectedCategoryIndex);

  //   final response = await http.post(
  //     Uri.parse('http://10.0.2.2:8000/api/post/updatePost'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Accept': '*/*',
  //       'connection': 'keep-alive',
  //     },
  //     body: jsonEncode(body),
  //   );

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final user = EditPost.fromJson(data);
  //     return user;
  //   } else {
  //     throw Exception('Failed to update data to the API');
  //   }
  // }

  Future<EditPost> updatePost() async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:8000/api/post/updatePost'),
    );

    // Add text fields
    request.fields['id'] = widget.post_id.toString();
    request.fields['title'] = titleController.text;
    request.fields['body'] = bodyController.text;
    request.fields['category'] = selectedCategoryIndex.toString();
    // request.fields['user_id'] = widget.user_id.toString();

    // Add image files
    for (int i = 0; i < imageFileList.length; i++) {
      File imageFile = File(imageFileList[i].path);
      String fieldName = 'img_content_${i + 1}';
      request.files.add(http.MultipartFile(
        fieldName,
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: 'image$i.png',
      ));
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseJson = await response.stream.bytesToString();
      final Map<String, dynamic> data = jsonDecode(responseJson);
      return EditPost.fromJson(data);
    } else {
      throw Exception('Failed to update data to the API');
    }
  }

  @override
  void initState() {
    super.initState();
    futureEditPost = fetchEditPost(widget.post_id);
    fetchCategoriesFromAPI();

    // Set selectedCategoryName based on selectedCategoryIndex
    if (selectedCategoryIndex >= 0 &&
        selectedCategoryIndex < categoryList.length) {
      selectedCategoryName = categoryList[selectedCategoryIndex];

      print('show' + selectedCategoryName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Form(
          key: _editReviewForm,
          child: Column(
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
                        const EdgeInsets.only(left: 40.0, right: 40, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "แก้ไขรีวิว",
                          style: GoogleFonts.prompt(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage(
                                          widget.user_id,
                                        )));
                          },
                          child: const Icon(
                            Icons.home,
                            color: Colors.white,
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
                width: 300,
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
                    DropdownButtonFormField<String>(
                      value: selectedCategoryName,
                      items: categoryList
                          .map<DropdownMenuItem<String>>((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedCategoryName = value ?? '';
                          if (selectedCategoryName == "หนังสือ") {
                            selectedCategoryIndex = 1;
                          } else if (selectedCategoryName ==
                              "สถานที่ท่องเที่ยว") {
                            selectedCategoryIndex = 2;
                          } else if (selectedCategoryName ==
                              "อาหาร/เครื่องดื่ม") {
                            selectedCategoryIndex = 3;
                          } else if (selectedCategoryName == "ร้านอาหาร") {
                            selectedCategoryIndex = 4;
                          } else if (selectedCategoryName == "ภาพยนต์") {
                            selectedCategoryIndex = 5;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                      imageUrls.removeAt(
                                          index); // อัปเดตรายการ URL ของรูปภาพด้วยการลบ URL ที่เกี่ยวข้อง
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (index < imageUrls.length) {
                      return Stack(
                        children: [
                          Image.network(
                            imageUrls[index],
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
                                      imageUrls.removeAt(index);
                                      // ทำการลบ URL นี้จากรายการรูปภาพที่ถูกเก็บไว้ในฐานข้อมูลของคุณด้วย
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
                      return const SizedBox(); // ส่วนที่เหลือให้แสดงเป็นช่องว่าง
                    }
                  },
                  itemCount: imageFileList.length + imageUrls.length < 3
                      ? imageFileList.length + imageUrls.length + 1
                      : imageFileList.length + imageUrls.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                    width: 400,
                    child: FilledButton(
                        onPressed: () async {
                          if (_editReviewForm.currentState!.validate()) {
                            print("edit Review Prograss");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfilePage(widget.user_id),
                              ),
                            );
                          }

                          EditPost res = await updatePost();
                          print("edit review Success");
                        },
                        child: const Text("บันทึกข้อมูล"))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
