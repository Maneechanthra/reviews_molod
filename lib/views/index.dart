import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/views/login.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(4, 35, 136, 1),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                width: 500,
              ),
              const SizedBox(
                height: 200,
              ),
              const Column(
                children: [],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Login(
                                  title: '',
                                )));
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(250, 255, 238, 0))),
                  child: Text(
                    "เริ่มต้นใช้งาน",
                    style: GoogleFonts.kanit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 27, 14, 211)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
