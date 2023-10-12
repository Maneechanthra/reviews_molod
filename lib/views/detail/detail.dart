import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/class_list/list_recom.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("รายละเอียดรีวิว"))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset("assets/img/recom_view/book.png"),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Lime Seedlings",
                style: GoogleFonts.prompt(
                    fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "วันที่รีวิว : 12/08/2566",
                style: GoogleFonts.prompt(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "คำอธิบาย",
                style: GoogleFonts.prompt(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.green),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              const Text(
                "วัดพระศรีรัตนศาสดารามหรือวัดพระแก้วเป็นวัดสำคัญของประเทศไทยอยู่คู่บ้านคู่เมืองมาตั้งแต่สมัยรัชกาลที่ 1 เนื่องจากรัชกาลที่ 1 โปรดเกล้าฯ ให้สร้างขึ้นใน พ.ศ. 2325 วัดพระศรีรัตนศาสดารามเป็นส่วนหนึ่งของพระบรมมหาราชวัง ตั้งอยู่ในเขตพระราชฐานชั้นนอก ภายในพระอุโบสถตกแต่งอย่างวิจิตรงดงามและเป็นที่ประดิษฐานของพระพุทธมหามณีรัตนปฏิมากรหรือพระแก้วมรกต นอกจากนี้ภายในวัดยังแบ่งกลุ่มอาคารออกเป็น 3 กลุ่ม ได้แก่ กลุ่มพระอุโบสถ กลุ่มฐานไพที กลุ่มอาคารและสิ่งประดับอื่นๆ ซึ่งควรค่าแก่การไปกราบไหว้พระขอพร รวมถึงชื่นชมความสวยงามของสถาปัตยกรรมภายในวัดเป็นอย่างยิ่ง",
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "ภาพเพิ่มเติม",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        EdgeInsets edgeInsets = index != 0
                            ? const EdgeInsets.only(left: 8.0)
                            : const EdgeInsets.all(0.0);
                        return Padding(
                          padding: edgeInsets,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              "assets/img/recom_view/book.png",
                              height: 100,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 500,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.share),
                      SizedBox(
                        width: 10,
                      ),
                      Text("แชร์"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
