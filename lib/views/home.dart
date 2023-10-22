import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/api/api_login.dart';
import 'package:reviews_molod/catgoly/banner.dart';
import 'package:reviews_molod/catgoly/catgoly.dart';
import 'package:reviews_molod/catgoly/recom_review.dart';
import 'package:reviews_molod/crud/add_Review.dart';
import 'package:reviews_molod/crud/addreview.dart';
import 'package:reviews_molod/views/login.dart';
import 'package:reviews_molod/views/profile/profile.dart';

class Home extends StatefulWidget {
  final int user_id;
  final String userName;
  final String email;
  const Home(this.user_id, this.userName, this.email, {Key? key})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 253),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
        backgroundColor: const Color.fromARGB(255, 238, 238, 253),
        title: const Padding(
          padding: EdgeInsets.only(right: 50.0),
          child: Center(
            child: Text(
              "FUN IN THE SUN",
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 127, 161, 255)),
              accountName: Text(
                widget.userName,
                style: GoogleFonts.kanit(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              accountEmail: Text(
                widget.email,
                style: GoogleFonts.kanit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              currentAccountPicture: Image.asset(
                "assets/logo.png",
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("ข้อมูลส่วนตัว"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(widget.user_id)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("ออกจากระบบ"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Login(
                              title: '',
                            )));
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 10),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "ยินดีต้อนรับ : คุณ ${widget.userName}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 38, 1, 59),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, bottom: 10, top: 5),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "มีรีวิวไหนที่หน้าสนใจบ้างไหม ?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 139, 139, 139),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: 400,
                  height: 220,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/img/banner.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 145, 178, 247),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   child: BannerPage(),
                // ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 5, bottom: 5),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Icon(Icons.category_rounded),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "หมวดหมู่",
                        style: GoogleFonts.kanit(
                          fontSize: 22,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 2.0, top: 5),
                  child: Catgoly(),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20, left: 5),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Icon(Icons.recommend),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "แนะนำสำหรับคุณ",
                          style: GoogleFonts.kanit(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                RecomReview(widget.user_id),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "รีวิว",
          style: GoogleFonts.prompt(color: Colors.white),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddReviewPage(widget.user_id, widget.email, widget.userName),
            ),
          );
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 127, 161, 255),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
