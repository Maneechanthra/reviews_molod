import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:reviews_molod/api/api_showData.dart';
import 'package:reviews_molod/api/api_showDataProfile.dart';
import 'package:reviews_molod/catgoly/review_with_me.dart';
import 'package:reviews_molod/profile/dataprivate.dart';

class ProfilePage extends StatefulWidget {
  final int user_id;
  const ProfilePage(this.user_id, {Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      backgroundColor: const Color.fromARGB(255, 238, 238, 253),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 238, 238, 253),
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0, right: 10),
          child: Center(
            child: Text("โปรไฟล์"),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(onTap: () {}, child: const Icon(Icons.logout_sharp)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: FutureBuilder<ShowUser>(
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

                    return Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Card(
                        elevation: 5,
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
                                          color:
                                              Color.fromARGB(255, 56, 0, 160)),
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
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 15,
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
        ),
      ),
    );
  }
}
