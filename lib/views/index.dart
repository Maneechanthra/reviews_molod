import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("logo.png"),
              Text("Reviews maLod"),
              SizedBox(
                height: 20,
              ),
              FilledButton(onPressed: () {}, child: Text("data"))
            ],
          ),
        ),
      ),
    );
  }
}
