import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/retry.dart';
import 'package:reviews_molod/api/api_login.dart';
import 'package:reviews_molod/views/home.dart';
import 'package:reviews_molod/views/register.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class Login extends StatefulWidget {
  const Login({super.key, required this.title});
  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late Future<ApiResponse> futureApiResponse;
  final _loginForm = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    futureApiResponse = fetchApi();
  }

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<LoginResponse> verifyLogin() async {
    final body = {
      'email': usernameController.text,
      'password': passwordController.text,
    };

    print('Email entered: ${body['email']}');

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "*/*",
        'connection': 'keep-alive',
        'Authorization': 'Bearer ' + globals.jwtToken,
      },
      body: jsonEncode(body),
    );

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = jsonDecode(response.body);

      if (data != null) {
        return LoginResponse.fromJson(data);
      } else {
        throw Exception('Failed to decode JSON data');
      }
    } else {
      throw Exception('Failed to Login.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                  future: futureApiResponse,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data!.textFromApi);
                    }
                    return const CircularProgressIndicator();
                  }),
              Center(
                child: Image.asset("assets/logo.png"),
              ),
              Text(
                "Reviews MoLods",
                style: GoogleFonts.prompt(
                    color: const Color.fromARGB(255, 4, 205, 212),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 30, right: 40),
                child: Form(
                  key: _loginForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "เข้าสู่ระบบ",
                        style: GoogleFonts.prompt(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: usernameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "อีเมล",
                          hintText: "กรอกอีเมล",
                        ),
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
                          border: OutlineInputBorder(),
                          labelText: "รหัสผ่าน",
                          hintText: "กรอกรหัสผ่าน",
                        ),
                        onChanged: (String value) {},
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Please enter your passsord'
                              : null;
                        },
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
                              if (_loginForm.currentState!.validate()) {
                                print("login Progress");
                                LoginResponse res = await verifyLogin();

                                if (res.loginStatus == 1) {
                                  displayDialog(
                                      context, "Success", "login Success");

                                  print("login Success");

                                  globals.isLoggedIn = true;
                                  globals.jwtToken = res.jwtToken;

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()));
                                } else {
                                  displayDialog(context, "Error",
                                      "Please check your email or password");
                                }
                              } else {
                                displayDialog(context, "Error",
                                    "Please check your email and password");
                              }
                            },
                            child: const Text("เข้าสู่ระบบ"),
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
                            const Text("ยังไม่มีบัญชีผู้ใช้?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()));
                                },
                                child: const Text("สมัครสมาชิก"))
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
