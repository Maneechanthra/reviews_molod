import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/api/api_showDetailPost.dart';
import 'package:http/http.dart' as http;
import 'package:reviews_molod/views/index.dart';
import 'package:share_plus/share_plus.dart';

class DetailPage extends StatefulWidget {
  final int Postid;
  DetailPage(this.Postid, {Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<List<ShowDetailPost>> futureShowDetailPost;

  @override
  void initState() {
    super.initState();
    futureShowDetailPost = fetchShowDetailPost(widget.Postid);
  }

  Future<List<ShowDetailPost>> fetchShowDetailPost(int Postid) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/posts/detail/$Postid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "*/*",
          'connection': 'keep-alive',
        });
    print(response.body);
    print(response.statusCode);
    print(Postid);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data.map((json) => ShowDetailPost.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 222, 222, 248),
          title: Text(
            "รายละเอียดรีวิว",
            style: GoogleFonts.kanit(),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageUrl,
                          // height: 100,
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      post.title,
                      style: GoogleFonts.prompt(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "วันที่รีวิว : ${post.createdAt}",
                      style: GoogleFonts.prompt(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "คำอธิบาย",
                      style: GoogleFonts.prompt(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.green),
                    ),
                    Text(
                      post.body,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "ภาพเพิ่มเติม",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // SizedBox(
                        //   height: 50,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: 3,
                        //     itemBuilder: (context, index) {
                        //       EdgeInsets edgeInsets = index != 0
                        //           ? const EdgeInsets.only(left: 8.0)
                        //           : const EdgeInsets.all(0.0);
                        //       final imageField = "img_content_${index + 1}";
                        //       return Padding(
                        //         padding: edgeInsets,
                        //         child: ClipRRect(
                        //           borderRadius: BorderRadius.circular(5),
                        //           child: Image.network(
                        //             post[imageField], // แสดงรูปภาพ
                        //             height: 100,
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 500,
                      child: ElevatedButton(
                        onPressed: () {
                          Share.share(post.title + "\n" + post.body);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.share),
                            SizedBox(
                              width: 10,
                            ),
                            Text("แชร์"),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
