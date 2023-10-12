import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/catgoly/review_with_me.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("โปรไฟล์"),
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
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.account_box,
                        size: 60,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sumet Maneechanthra",
                            style: GoogleFonts.prompt(fontSize: 19),
                          ),
                          Text(
                            "เบอร์โทรศัพท์ : 0630038428",
                            style: GoogleFonts.prompt(fontSize: 10),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.edit,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "รีวิวของฉัน",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: ReviewWithMe(),
            )
          ],
        ),
      ),
    );
  }
}
