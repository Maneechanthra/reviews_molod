import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/api/api_showposttavel.dart';
import 'package:http/http.dart' as http;
import 'package:reviews_molod/views/detail_review.dart';

class DetailCategoryPage extends StatefulWidget {
  final int categoryId;
  DetailCategoryPage(this.categoryId, {Key? key}) : super(key: key);

  @override
  State<DetailCategoryPage> createState() => _DetailCategoryPageState();
}

class _DetailCategoryPageState extends State<DetailCategoryPage> {
  String searchText = "";
  late Future<List<ShowPostTavel>> futureShowPostTavel;

  @override
  void initState() {
    super.initState();
    futureShowPostTavel = fetchShowPostTavel(widget.categoryId);
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
                  final filteredPosts =
                      filterPostsBySearch(snapshot.data!, searchText);
                  return ListView.builder(
                    itemCount: filteredPosts.length,
                    itemBuilder: (context, index) {
                      final post = filteredPosts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPost(post.id),
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
                                        'http://10.0.2.2:8000/api/storage/img_content/${post.img_content_1}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
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

  List<ShowPostTavel> filterPostsBySearch(
      List<ShowPostTavel> posts, String query) {
    if (query.isEmpty) {
      return posts;
    }

    final lowerCaseQuery = query.toLowerCase();
    return posts.where((post) {
      return post.title.toLowerCase().contains(lowerCaseQuery) ||
          post.body.toLowerCase().contains(lowerCaseQuery);
    }).toList();
  }
}
