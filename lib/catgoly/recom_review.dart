import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/class_list/list_recom.dart';
import 'package:reviews_molod/views/book.dart';
import 'package:reviews_molod/views/movie.dart';
import 'package:reviews_molod/views/restaurant.dart';
import 'package:reviews_molod/views/tavel.dart';

class RecomReview extends StatefulWidget {
  const RecomReview({Key? key}) : super(key: key);

  @override
  State<RecomReview> createState() => _RecomReviewState();
}

class _RecomReviewState extends State<RecomReview> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridView.count(
        childAspectRatio: 0.7,
        crossAxisCount: 2,
        shrinkWrap: true,
        children: List.generate(ListRecomPage.length, (index) {
          return Card(
            elevation: 0.7,
            child: InkWell(
              onTap: () {
                if (ListRecomPage[index].name == "วัดพระแก้ว") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Tavel()));
                } else if (ListRecomPage[index].name == "ร้านฟาร์มฮัก") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Restaurant()));
                } else if (ListRecomPage[index].name == "Ballerina") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Moive()));
                } else if (ListRecomPage[index].name ==
                    "สรุปข้อคิดจากหนังสือ “THE HAPPIEST PERSON IN THE ROOM อยู่เย็นเป็นสูตร") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Book()));
                }
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
