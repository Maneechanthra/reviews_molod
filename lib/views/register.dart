import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:reviews_molod/api/api_login.dart';
import 'package:reviews_molod/api/api_register.dart';
// import 'package:reviews_molod/views/home.dart';
import 'package:reviews_molod/views/login.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late Future<ApiResponseRegister> futureApiResponse;
  final _registerForm = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final ConfirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    ConfirmPasswordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    futureApiResponse = fetchApi();
  }

  Future<RegisterResponse> register() async {
    final body = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    };

    print(body['email']);

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
        'Authorization': 'Bearer ' + globals.jwtToken,
      },
      body: jsonEncode(body),
    );

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic>? data = jsonDecode(response.body);
      if (data != null) {
        return RegisterResponse.fromJson(data);
      } else {
        throw Exception('failed to decode json data');
      }
    } else {
      throw Exception("faild register");
    }
  }

  void displayDialog(context, title, text) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(text),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(4, 35, 136, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // FutureBuilder(
              //     future: futureApiResponse,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Text(snapshot.data!.textFromApi);
              //       }
              //       return const CircularProgressIndicator();
              //     }),
              Center(
                child: Image.asset(
                  "assets/logo.png",
                  width: 200,
                ),
              ),
              Text(
                "สมัครสมาชิก",
                style: GoogleFonts.prompt(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Form(
                  key: _registerForm,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled:
                              true, // Add this to enable filling with background color
                          fillColor:
                              Colors.white, // Set the background color to white
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),

                          hintText: 'ชื่อ-สกุล',
                        ),
                        onChanged: (String value) {},
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Please enter your name'
                              : null;
                        },
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // TextFormField(
                      //   controller: telephoneNumberController,
                      //   keyboardType: TextInputType.text,
                      //   decoration: InputDecoration(
                      //       border: OutlineInputBorder(),
                      //       labelText: 'เบอร์โทรศัพท์',
                      //       hintText: 'กรอกเบอร์โทรศัพท์'),
                      //   onChanged: (String value) {},
                      //   validator: (value) {
                      //     return value!.isEmpty
                      //         ? 'please enter your telephone number'
                      //         : null;
                      //   },
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            filled:
                                true, // Add this to enable filling with background color
                            fillColor: Colors
                                .white, // Set the background color to white
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: 'อีเมล'),
                        onChanged: (String value) {},
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Please enter your email'
                              : null;
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            filled:
                                true, // Add this to enable filling with background color
                            fillColor: Colors
                                .white, // Set the background color to white
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: 'รหัสผ่าน'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: ConfirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            filled:
                                true, // Add this to enable filling with background color
                            fillColor: Colors
                                .white, // Set the background color to white
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: 'ยืนยันรหัสผ่าน'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: 500,
                          height: 40,
                          child: FilledButton(
                            onPressed: () async {
                              if (passwordController.text ==
                                  ConfirmPasswordController.text) {
                                print("รหัสผ่านตรงกัน");
                                if (_registerForm.currentState!.validate()) {
                                  print("Register Progress");
                                  RegisterResponse res = await register();
                                  print("register success");
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Login(title: "")));
                                  // ignore: use_build_context_synchronously
                                  displayDialog(
                                      context, "success", "สมัครสมาชิกสำเร็จ!");
                                }
                              } else {
                                displayDialog(
                                    context, "Error", "รหัสผ่านไม่ตรงกัน");
                              }
                            },
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(250, 255, 238, 0))),
                            child: const Text(
                              "สมัครสมาชิก",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "มีบัญชีผู้ใช้?",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 250, 250, 250)),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login(
                                                title: '',
                                              )));
                                },
                                child: const Text(
                                  "เข้าสู่ระบบ",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
