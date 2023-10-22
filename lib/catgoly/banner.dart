import 'package:flutter/material.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({Key? key}) : super(key: key);

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount:
          1, // You can change this to the actual number of banners you want to display.
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: 400,
          height: 220,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/img/banner.jpg"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFF9ADAFF), // Changed to a more readable color
                blurRadius: 30,
                offset: Offset(0, 10),
              ),
            ],
          ),
        );
      },
    );
  }
}
