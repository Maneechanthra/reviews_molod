import 'package:flutter/material.dart';

class Tavel extends StatefulWidget {
  const Tavel({super.key});

  @override
  State<Tavel> createState() => _TavelState();
}

class _TavelState extends State<Tavel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Center(child: Text("รีวิวสถานที่ท่องเที่ยว"))),
      body: ListView(children: [Card()]),
    );
  }
}
