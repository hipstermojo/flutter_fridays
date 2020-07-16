import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final double height = 400;
  final double width = 300;
  final double clipSize = 100;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Color(0xFF465254),
        body: Center(
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: [
              ClipPath(
                clipper: CardClipper(edgeSize: clipSize),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(10.0)),
                  height: height,
                  width: width,
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                            "Useful hints to build a perfect design for iPhone XS")
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -width + clipSize,
                top: -height + clipSize,
                child: Transform.rotate(
                  angle: 0,
                  child: ClipPath(
                    clipper: CardClipper(edgeSize: clipSize, clipReverse: true),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(10.0)),
                      height: height,
                      width: width,
                      child: Text("Some text"),
                    ),
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

class CardClipper extends CustomClipper<Path> {
  /// A custom clipper that cuts the card edge. [edgeSize] refers the size of
  /// the diagonal cut on the card. [clipReverse] is used to determine if the
  /// clipping starts from the top right to the bottom left (the default behaviour)
  /// or when set to [true] clips from the bottom left towards the top right
  CardClipper({@required this.edgeSize, this.clipReverse = false});
  final double edgeSize;
  final bool clipReverse;
  @override
  Path getClip(Size size) {
    Path path = Path();
    if (clipReverse) {
      path
        ..lineTo(0.0, size.height)
        ..lineTo(edgeSize, size.height)
        ..lineTo(0.0, size.height - edgeSize);
    } else {
      path
        //Top left
        ..lineTo(0.0, 0.0)
        // Bottom left
        ..lineTo(0.0, size.height)
        // Bottom right
        ..lineTo(size.width, size.height)
        // Top Right
        ..lineTo(size.width, edgeSize)
        ..lineTo(size.width - edgeSize, 0.0)
        ..close();
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
