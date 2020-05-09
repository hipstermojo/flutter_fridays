import 'package:flutter/material.dart';

import 'package:humidity_slider/widgets/bottom_nav.dart';
import 'package:humidity_slider/widgets/reading_summary.dart';
import 'package:humidity_slider/widgets/readings.dart';
import 'package:humidity_slider/widgets/slider_controller.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  final Color redGradient = Color(0xff560920);
  final Color blueGradient = Color(0xff2b6799);
  final Color backgroundColor = Color(0xff173051);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Humidity Slider",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Montserrat",
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white.withAlpha(128))),
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Row(
                children: <Widget>[
                  Expanded(
                    child: Readings(),
                    flex: 1,
                  ),
                  Expanded(
                    child: SliderController(),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 20.0),
                      child: ReadingSummary(),
                    ),
                    flex: 3,
                  ),
                ],
              ))),
              BottomNav()
            ],
          ),
        ),
      ),
    );
  }
}
