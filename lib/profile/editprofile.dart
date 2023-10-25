import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reviews_molod/api/api_showData.dart';
import 'package:http/http.dart' as http;
import 'package:reviews_molod/views/home.dart';
import 'package:reviews_molod/profile/dataprivate.dart';

class EditProfile extends StatefulWidget {
  final int user_id;
  const EditProfile(this.user_id, {super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late Future<ShowUser> futureShowUser;
  final _editProfileForm = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureShowUser = fetchShowUser(widget.user_id);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
  }

  Future<ShowUser> fetchShowUser(int user_id) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/user/$user_id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final user = ShowUser.fromJson(data);

      nameController.text = user.name;
      emailController.text = user.email;

      return user;
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<ShowUser> fetchUpdateUser() async {
    final body = {
      'id': widget.user_id,
      'name': nameController.text,
      'email': emailController.text,
    };

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/user/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final user = ShowUser.fromJson(data);
      return user;
    } else {
      throw Exception('Failed to update data to the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: Text("แก้ไขข้อมูลส่วนตัว"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _editProfileForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Image.asset(
                  "assets/logo.png",
                  width: 100,
                ),
              ),
              Text(
                "แก้ไขข้อมูลส่วนตัว",
                style: GoogleFonts.prompt(
                  color: const Color.fromARGB(255, 4, 205, 212),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ชื่อ',
                        hintText: 'กรอกชื่อ-นามสกุล',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'อีเมล',
                        hintText: 'กรอกอีเมล',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        width: 500,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_editProfileForm.currentState!.validate()) {
                              print("Updating user data in progress");
                              ShowUser res = await fetchUpdateUser();
                              print("User data updated successfully");

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Home(res.id, res.name, res.email)));
                            }
                          },
                          child: const Text("บันทึกข้อมูล"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
