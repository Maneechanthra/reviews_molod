import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/catgoly/catgoly.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
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
          children: const [
            UserAccountsDrawerHeader(
              accountName: Text("Sumet Maneechanthra"),
              accountEmail: Text("sumet.ma@ku.th"),
              currentAccountPicture: FlutterLogo(),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.black,
                  ),
                  height: 150, // Adjust the height as needed
                ),
                const SizedBox(
                  height: 10,
                ),
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
                    // image: const DecorationImage(
                    //   image: AssetImage("img/banner.jpg"),
                    //   fit: BoxFit.cover,
                    // ),
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
                  padding: EdgeInsets.only(left: 15.0),
                  child: Catgoly(),
                ),
                // Container(
                //     margin: const EdgeInsets.only(top: 20, left: 15),
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       "แนะนำสำหรับคุณ",
                //       style: GoogleFonts.prompt(
                //           fontSize: 20, fontWeight: FontWeight.bold),
                //     )),
                // const RecomReview(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
