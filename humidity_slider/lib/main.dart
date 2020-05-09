import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  final Color redGradient = Color(0xff560920);
  final Color blueGradient = Color(0xff2b6799);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Montserrat"),
      home: Scaffold(
        backgroundColor: Color(0xff173051),
        body: Center(child: Text("Some Text")),
      ),
    );
  }
}
