import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/api/api_showDetailPost.dart';
import 'package:http/http.dart' as http;
import 'package:reviews_molod/views/home.dart';
import 'package:share_plus/share_plus.dart';

class DetailPost extends StatefulWidget {
  final int Postid;
  DetailPost(this.Postid, {Key? key}) : super(key: key);

  @override
  State<DetailPost> createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  late Future<List<ShowDetailPost>> futureShowDetailPost;

  @override
  void initState() {
    super.initState();
    futureShowDetailPost = fetchShowDetailPost(widget.Postid);
    print(widget.Postid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: futureShowDetailPost,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("เกิดข้อผิดพลาด: ${snapshot.error}"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("ไม่พบข้อมูล"),
              );
            } else {
              final post = snapshot.data![0];
              final String imageUrl =
                  'http://10.0.2.2:8000/api/storage/img_content/${post.imgContent1}';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 350,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 194, 149, 245),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(115, 85, 85, 85),
                            offset: Offset(0.0, 8.0),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                            child: Image.network(
                              imageUrl, fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              // height: 100,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 50.0,
                                left: 20,
                                right: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.home),
                                      onPressed: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const Home(user_id,
                                        //                 userName, email)));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.location_pin),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 310,
                              child: Text(
                                post.title,
                                style: GoogleFonts.kanit(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "วันที่รีวิว : ${post.createdAt}",
                          style: GoogleFonts.kanit(
                            fontSize: 16,
                            color: Color.fromARGB(255, 133, 34, 247),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 190,
                          child: Text(
                            post.body,
                            style: GoogleFonts.kanit(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            const Icon(Icons.photo_album_outlined),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "รูปภาพเพิ่มเติม",
                              style: GoogleFonts.kanit(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3, // จำนวนรูปภาพที่ต้องการแสดง
                            itemBuilder: (context, index) {
                              final int imgContentIndex =
                                  index + 1; // เพิ่มเลขตั้งแต่ 1
                              EdgeInsets edgeInsets = index != 0
                                  ? const EdgeInsets.only(left: 8.0)
                                  : const EdgeInsets.all(0.0);
                              String imageUrl_post;

                              if (imgContentIndex == 1) {
                                imageUrl_post =
                                    'http://10.0.2.2:8000/api/storage/img_content/${post.imgContent1}';
                              } else if (imgContentIndex == 2) {
                                imageUrl_post =
                                    'http://10.0.2.2:8000/api/storage/img_content/${post.imgContent2}';
                              } else {
                                imageUrl_post =
                                    'http://10.0.2.2:8000/api/storage/img_content/${post.imgContent3}';
                              }

                              print(imageUrl_post);
                              return Padding(
                                padding: edgeInsets,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    imageUrl_post, // แสดงรูปภาพ
                                    height: 100,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 370,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Share.share(post.title + "\n" + post.body);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 134, 36, 247)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.share),
                            SizedBox(width: 10),
                            Text("แชร์"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
