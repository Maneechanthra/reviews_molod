import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/views/login.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("logo.png"),
              Text(
                "Reviews maLod",
                style: GoogleFonts.prompt(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 4, 205, 212),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 250,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: const Text("Get"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
