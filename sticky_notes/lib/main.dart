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
          child: FoldableCard(width: width, clipSize: clipSize, height: height),
        ),
      ),
    );
  }
}

class FoldableCard extends StatelessWidget {
  const FoldableCard({
    Key key,
    @required this.width,
    @required this.clipSize,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double clipSize;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: CardClipper(
              startOffset: Offset(width - clipSize, 0),
              endOffset: Offset(width, clipSize)),
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
        Positioned(
          right: -width + clipSize,
          top: -height + clipSize,
          child: Transform.rotate(
            angle: 0,
            child: ClipPath(
              clipper: CardClipper(
                  startOffset: Offset(0, height - clipSize),
                  endOffset: Offset(clipSize, height)),
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
    );
  }
}

class CardClipper extends CustomClipper<Path> {
  /// A custom clipper that cuts the card edge. [startOffset] is an Offset
  /// of the start of the edge and [endOffset] is an Offset of the end of
  /// the edge. The cut edge runs diagonally from the top left to the bottom
  /// right
  CardClipper({@required this.startOffset, @required this.endOffset});

  Offset startOffset;
  final Offset endOffset;
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Bottom left
    path..moveTo(0.0, size.height);
    //Top left
    path..lineTo(0.0, startOffset.dy);
    // Top Right
    path..lineTo(startOffset.dx, startOffset.dy);
    path..lineTo(endOffset.dx, endOffset.dy);
    // Bottom right
    path..lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CardClipper oldClipper) =>
      oldClipper.startOffset != startOffset ||
      oldClipper.endOffset != endOffset;
}
