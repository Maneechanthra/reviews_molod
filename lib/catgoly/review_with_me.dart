import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/api/api_showDataProfile.dart';
import 'package:reviews_molod/crud/edit_Review.dart';

class ReviewWithMe extends StatefulWidget {
  final int user_id;
  const ReviewWithMe(this.user_id, {Key? key}) : super(key: key);
  @override
  State<ReviewWithMe> createState() => _ReviewWithMeState();
}

class _ReviewWithMeState extends State<ReviewWithMe> {
  late Future<List<ShowDataProfile>> futureShowPost;

  @override
  void initState() {
    super.initState();
    futureShowPost = fetchShowPostUser(widget.user_id);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<ShowDataProfile>>(
        future: futureShowPost,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // แสดง Indicator ในระหว่างโหลดข้อมูล
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return GridView.count(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(snapshot.data!.length, (index) {
                print("ID: ${snapshot.data![index].post_id}");

                print("title : ${snapshot.data![index].title}");
                final String imageUrl =
                    'http://10.0.2.2:8000/api/storage/img_content/${snapshot.data![index].imgContent1}';
                print(imageUrl);
                return Card(
                  color: Color.fromARGB(255, 244, 244, 255),
                  elevation: 5,
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              imageUrl,
                              height: 100,
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data![index].post_title,
                                style: GoogleFonts.prompt(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                snapshot.data![index].body,
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
                                "วันที่รีวิว : " +
                                    snapshot.data![index].created_at,
                                style: GoogleFonts.prompt(
                                  fontSize: 10,
                                  color:
                                      const Color.fromARGB(221, 168, 168, 168),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditReviewPage(
                                                    widget.user_id,
                                                    snapshot
                                                        .data![index].post_id,
                                                  )));
                                    },
                                    child: const Icon(
                                      Icons.edit_note,
                                      size: 30,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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
