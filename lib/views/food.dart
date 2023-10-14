import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Food extends StatefulWidget {
  const Food({super.key});

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("รีวิวอาหาร")),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: const InputDecoration(
                labelText: "ค้นหา...",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(children: [
                            Image.asset(
                              "assets/logo.png",
                              width: 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ชื่ออาหาร",
                                    style: GoogleFonts.prompt(fontSize: 20),
                                  ),
                                  const Text(
                                      "รายละเอียดอาหารที่ต้องการรีวิว..."),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text("วันที่รีวิว : 12/05/2566"),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
