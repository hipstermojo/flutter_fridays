import 'package:flutter/material.dart';

import 'package:humidity_slider/widgets/bottom_nav.dart';

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
      theme: ThemeData(
          fontFamily: "Montserrat",
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white.withAlpha(128))),
      home: Scaffold(
        backgroundColor: Color(0xff173051),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Center(
                child: Text("Scale goes here"),
              )),
              BottomNav()
            ],
          ),
        ),
      ),
    );
  }
}
