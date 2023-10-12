import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/class_list/list_recom.dart';
import 'package:reviews_molod/class_list/listmenu.dart';
import 'package:reviews_molod/views/detail/detail.dart';
import 'package:reviews_molod/views/index.dart';

class ReviewWithMe extends StatefulWidget {
  const ReviewWithMe({super.key});

  @override
  State<ReviewWithMe> createState() => _ReviewWithMeState();
}

class _ReviewWithMeState extends State<ReviewWithMe> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridView.count(
        childAspectRatio: 0.5,
        crossAxisCount: 3,
        shrinkWrap: true,
        children: List.generate(ListRecomPage.length, (index) {
          return Card(
            elevation: 0.7,
            child: InkWell(
              onTap: () {
                // ทำอะไรสักอย่างเมื่อคลิกที่ Card
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      ListRecomPage[index].img,
                      height: 150,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ListRecomPage[index].name,
                          style: GoogleFonts.prompt(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          ListRecomPage[index].detail,
                          style: GoogleFonts.prompt(
                            fontSize: 10,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          ListRecomPage[index].date,
                          style: GoogleFonts.prompt(
                              fontSize: 10,
                              color: const Color.fromARGB(221, 168, 168, 168)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
