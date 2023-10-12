import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/catgoly/catgoly.dart';
import 'package:reviews_molod/catgoly/recom_review.dart';
import 'package:reviews_molod/views/login.dart';
import 'package:reviews_molod/views/profile/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("ReViews MaLods"),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("Sumet Maneechanthra"),
              accountEmail: const Text("sumet.ma@ku.th 5555"),
              currentAccountPicture: Image.asset("assets/logo.png"),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("ข้อมูลส่วนตัว"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("ออกจากระบบ"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
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
                      child: Text(
                        "ยินดีต้อนรับ : ",
                        style: GoogleFonts.prompt(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "คุณ Sumet Maneechanthra",
                        style: GoogleFonts.prompt(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: 460,
                  height: 220,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/img/banner.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 165, 165, 165),
                        blurRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 15, bottom: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "หมวดหมู่",
                    style: GoogleFonts.prompt(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Catgoly(),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20, left: 15),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "แนะนำสำหรับคุณ",
                      style: GoogleFonts.prompt(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                const RecomReview(),
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
        onPressed: () {},
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 14, 195, 219),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
