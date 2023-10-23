import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/api/api_showData.dart';
import 'package:reviews_molod/profile/editprofile.dart';
import 'package:http/http.dart' as http;

class DataPrivate extends StatefulWidget {
  final int user_id;
  const DataPrivate(this.user_id, {Key? key}) : super(key: key);

  @override
  State<DataPrivate> createState() => _DataPrivateState();
}

class _DataPrivateState extends State<DataPrivate> {
  late Future<ShowUser> futureShowUser;

  @override
  void initState() {
    super.initState();
    futureShowUser = fetchShowUser(widget.user_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 253),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 238, 238, 253),
        title: const Center(
          child: Text("ข้อมูลส่วนตัว"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ข้อมูลส่วนตัว",
                                  style: GoogleFonts.prompt(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfile(userData.id)));
                                    },
                                    child: const Icon(Icons.edit))
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ชื่อ",
                                  style: GoogleFonts.prompt(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  userData.name,
                                  style: GoogleFonts.prompt(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "อีเมล",
                                  style: GoogleFonts.prompt(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  userData.email,
                                  style: GoogleFonts.prompt(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       "เบอร์โทรศัพท์",
                            //       style: GoogleFonts.prompt(
                            //         fontSize: 14,
                            //       ),
                            //     ),
                            //     Text(
                            //       "0630038428",
                            //       style: GoogleFonts.prompt(
                            //         fontSize: 14,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        );
                      }
                    }),
              )),
        ),
      ),
    );
  }
}
