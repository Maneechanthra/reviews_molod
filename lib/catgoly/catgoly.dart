import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/class_list/listmenu.dart';
import 'package:reviews_molod/views/book.dart';
import 'package:reviews_molod/views/food.dart';
import 'package:reviews_molod/views/movie.dart';
import 'package:reviews_molod/views/restaurant.dart';
import 'package:reviews_molod/views/tavel.dart';

class Catgoly extends StatelessWidget {
  const Catgoly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (Listpage[index].name == "สถานที่ท่องเที่ยว") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Tavel()),
                  );
                } else if (Listpage[index].name == "อาหาร/เครื่องดื่ม") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Food()),
                  );
                } else if (Listpage[index].name == "ภาพยนต์") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Moive()));
                } else if (Listpage[index].name == "ร้านอาหาร") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Restaurant()));
                } else {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Book()));
                }
              },
              child: Chip(
                label: Text(
                  Listpage[index].name,
                  style: GoogleFonts.prompt(),
                ),
                avatar: CircleAvatar(
                  backgroundImage: AssetImage(Listpage[index].img),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Padding(padding: EdgeInsets.only(right: 10)),
          itemCount: Listpage.length,
        ),
      ),
    );
  }
}
