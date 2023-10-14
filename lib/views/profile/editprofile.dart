import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/views/profile/dataprivate.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Padding(
          padding: EdgeInsets.only(right: 50.0),
          child: Text("แก้ไขข้อมูลส่วนตัว"),
        ),
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/logo.png",
              width: 100,
            ),
          ),
          Text(
            "แก้ไขข้อมูลส่วนตัว",
            style: GoogleFonts.prompt(
                color: const Color.fromARGB(255, 4, 205, 212),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ชื่อภาษาไทย',
                      hintText: 'กรอกชื่อ-นามสกุล'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'เบอร์โทรศัพท์',
                      hintText: 'กรอกเบอร์โทรศัพท์'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'อีเมล',
                      hintText: 'กรอกอีเมล'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: 500,
                    height: 40,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DataPrivate()));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.save), Text("บันทึกข้อมูล")],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
