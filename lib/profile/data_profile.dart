import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/api/api_showData.dart';
import 'package:reviews_molod/api/api_showDataProfile.dart';
import 'package:reviews_molod/catgoly/review_with_me.dart';
import 'package:reviews_molod/profile/dataprivate.dart';
import 'package:http/http.dart' as http;

class DataProfilePage extends StatefulWidget {
  final int user_id;
  const DataProfilePage(this.user_id, {Key? key}) : super(key: key);
  @override
  State<DataProfilePage> createState() => _DataProfilePageState();
}

class _DataProfilePageState extends State<DataProfilePage> {
  late Future<ShowUser> futureShowUser;
  late Future<ShowDataProfile> futureShowPost;

  @override
  void initState() {
    super.initState();
    futureShowUser = fetchShowUser(widget.user_id);
  }

  Future<ShowUser> fetchShowUser(int userId) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/user/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ShowUser.fromJson(data);
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: futureShowUser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("เกิดข้อผิดพลาด : ${snapshot.error}"),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text("ไม่พบข้อมูล"),
                );
              } else {
                final userData = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 300,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(80),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(115, 85, 85, 85),
                            offset: Offset(0.0, 8.0),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(80)),
                          child: Image.asset(
                            "assets/img/banner.jpg",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 50.0, left: 20, right: 20),
                            child: Row(
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
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.account_circle_sharp,
                                size: 70,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "ชื่อ : " + userData.name,
                                      style: GoogleFonts.kanit(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(
                                              255, 154, 124, 209)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "อีเมล : " + userData.email,
                                    style: GoogleFonts.kanit(fontSize: 16),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DataPrivate(userData.id),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.edit,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 22.0),
                      child: Row(
                        children: [
                          const Icon(Icons.reviews_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "รีวิวของฉัน",
                            style: GoogleFonts.kanit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ReviewWithMe(widget.user_id),
                    )
                  ],
                );
              }
            }),
      ),
    );
  }
}
