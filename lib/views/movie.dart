import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/api/api_showposttavel.dart';
import 'package:reviews_molod/views/detail/detail.dart';
import 'package:http/http.dart' as http;

class Movie extends StatefulWidget {
  final int categoryId;
  Movie(this.categoryId, {Key? key}) : super(key: key);

  @override
  State<Movie> createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  String searchText = "";
  late Future<List<ShowPostTavel>> futureShowPostTavel;

  @override
  void initState() {
    super.initState();
    futureShowPostTavel = fetchShowPostTavel(widget.categoryId);
  }

  Future<List<ShowPostTavel>> fetchShowPostTavel(int categoryId) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/posts/tavel/$categoryId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "*/*",
          'connection': 'keep-alive',
        });
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data.map((json) => ShowPostTavel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 253),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 238, 238, 253),
        title: const Text("รีวิวภาพยนต์"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: const InputDecoration(
                labelText: "ค้นหา...",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ShowPostTavel>>(
              future: futureShowPostTavel,
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
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data![index];
                      final String imageUrl =
                          'http://10.0.2.2:8000/api/storage/img_content/${post.img_content_1}';
                      // final imgURL = post.img_content_1;
                      // print("ภาพ " + imgURL);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(post.id),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 5.0,
                            left: 10,
                            right: 10,
                          ),
                          child: Card(
                            elevation: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 220,
                                          child: Text(
                                            post.title, // แสดงชื่อสถานที่จาก API
                                            style: GoogleFonts.prompt(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 250,
                                          child: Text(
                                            post.body,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Text(
                                          "วันที่รีวิว : ${post.created_at}",
                                          style:
                                              GoogleFonts.prompt(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
