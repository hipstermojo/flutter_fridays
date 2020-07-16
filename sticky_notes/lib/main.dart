import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final double height = 400;
  final double width = 300;
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
          child: ClipPath(
            clipper: RoundedClipper(edgeSize: 20.0),
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
                    Text("Useful hints to build a perfect design for iPhone XS")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedClipper extends CustomClipper<Path> {
  RoundedClipper({@required this.edgeSize});
  final double edgeSize;
  @override
  Path getClip(Size size) {
    final path = Path()
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
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
