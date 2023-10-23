import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/api/api_recomment.dart';
import 'package:reviews_molod/views/detail_review.dart';

class RecomReview extends StatefulWidget {
  final int user_id;
  const RecomReview(this.user_id, {Key? key}) : super(key: key);

  @override
  State<RecomReview> createState() => _RecomReviewState();
}

class _RecomReviewState extends State<RecomReview> {
  late Future<List<RecommentMOdel>> futureShowPostRecomment;

  @override
  void initState() {
    super.initState();
    futureShowPostRecomment = fetchShowRecoment();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<RecommentMOdel>>(
        future: futureShowPostRecomment,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // Use futureShowPostRecomment here
            return GridView.count(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(snapshot.data!.length, (index) {
                final String imageUrl =
                    'http://10.0.2.2:8000/api/storage/img_content/${snapshot.data![index].imgContent1}';
                return Padding(
                  padding: const EdgeInsets.only(left: 3.0, right: 3),
                  child: Card(
                    color: Colors.white,
                    elevation: 3.0, // เพิ่มเงา
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // กำหนดขอบของการ์ด
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailPost(snapshot.data![index].id)));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Card(
                              elevation: 0.0, // ไม่มีเงา
                              child: Image.network(
                                imageUrl,
                                height: 150,
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data![index].title,
                                  style: GoogleFonts.prompt(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  width: 220,
                                  child: Text(
                                    snapshot.data![index].body,
                                    style: GoogleFonts.prompt(
                                      fontSize: 10,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    snapshot.data![index].createdAt,
                                    style: GoogleFonts.prompt(
                                      fontSize: 10,
                                      color: const Color(0xFFA8A8A8),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          } else {
            return Text('No data available');
          }
        },
      ),
    );
  }
}
