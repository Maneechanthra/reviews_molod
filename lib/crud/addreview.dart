import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AddReviews extends StatefulWidget {
  const AddReviews({super.key});

  @override
  State<AddReviews> createState() => _AddReviewsState();
}

class _AddReviewsState extends State<AddReviews> {
  DateTime? selectedDate;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  void selectedImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    setState(() {
      imageFileList.addAll(selectedImages);
    });
  }

  // Future<List<String>> _saveImages() async {
  //   List<String> imagePaths = [];
  //   for (XFile imageFile in imageFileList) {
  //     Directory appDocDir = await getApplicationDocumentsDirectory();
  //     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //     String imagePath = '${appDocDir.path}/$fileName.png';

  //     await File(imageFile.path).copy(imagePath);
  //     imagePaths.add(imagePath);
  //   }
  //   return imagePaths;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 185, 226),
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: Text("เพิ่มรีวิว"),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Image.asset(
                "assets/logo.png",
                width: 50,
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "ชื่อสถานที่",
                            hintText: 'กรอกชื่อสถานที่',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
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
                                  onPressed: () {}, child: const Text("Save"))),
                        ),
                      ],
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
