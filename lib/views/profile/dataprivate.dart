import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/views/profile/editprofile.dart';

class DataPrivate extends StatefulWidget {
  const DataPrivate({super.key});

  @override
  State<DataPrivate> createState() => _DataPrivateState();
}

class _DataPrivateState extends State<DataPrivate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("ข้อมูลส่วนตัว"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ข้อมูลส่วนตัว",
                      style: GoogleFonts.prompt(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditProfile()));
                        },
                        child: const Icon(Icons.edit))
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ชื่อภาษาไทย",
                      style: GoogleFonts.prompt(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "นายุสเมธ มณีจันทรา",
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
                      "sumet.ma@ku.th",
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
                      "เบอร์โทรศัพท์",
                      style: GoogleFonts.prompt(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "0630038428",
                      style: GoogleFonts.prompt(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
