import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/views/home.dart';
import 'package:reviews_molod/views/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "สมัครสมาชิก",
            style: GoogleFonts.prompt(
                color: const Color.fromARGB(255, 4, 205, 212),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ชื่อ-สกุล',
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
                const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'รหัสผ่าน',
                      hintText: 'กรอกรหัสผ่าน'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ยืนยันรหัสผ่าน',
                      hintText: 'กรอกยืนยันรหัสผ่าน'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 500,
                    height: 40,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: const Text("สมัครสมาชิก"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("มีบัญชีผู้ใช้?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          },
                          child: const Text("เข้าสู่ระบบ"))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
