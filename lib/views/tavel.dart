import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/views/detail/detail.dart';
import 'package:reviews_molod/views/register.dart';
import 'package:reviews_molod/class_list/list_recom.dart';

class Tavel extends StatefulWidget {
  const Tavel({super.key});

  @override
  State<Tavel> createState() => _TavelState();
}

class _TavelState extends State<Tavel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("รีวิวสถานที่ท่องเที่ยว")),
      ),
      body: ListView.builder(
        itemCount: ListRecomPage.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DetailPage()));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 10, right: 10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            ListRecomPage[index].img,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ชื่อสถานที่ท่องเที่ยว",
                              style: GoogleFonts.prompt(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Text("รายละเอียดรีวิวสถานที่ท่องเที่ยว..."),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "วันที่รีวิว : 12/08/2566",
                              style: GoogleFonts.prompt(fontSize: 10),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
