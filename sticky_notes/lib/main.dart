import 'dart:math';

import 'package:flutter/material.dart';

const PIVOT_ANGLE = (45 * pi) / 180;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final double height = 400;
  final double width = 300;
  final double clipSize = 20;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Poppins",
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

class FoldableCard extends StatefulWidget {
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
  _FoldableCardState createState() => _FoldableCardState();
}

class _FoldableCardState extends State<FoldableCard> {
  double rightPos;
  double topPos;
  Offset cardStartOffset;
  Offset cardEndOffset;
  Offset foldStartOffset;
  Offset foldEndOffset;
  double angle;
  double cardSizeDiff;
  @override
  void initState() {
    super.initState();
    cardSizeDiff = (widget.width - widget.height).abs() / 2;
    rightPos = -widget.width - cardSizeDiff + widget.clipSize;
    topPos = -widget.height + cardSizeDiff + widget.clipSize;
    cardStartOffset = Offset(widget.width - widget.clipSize, 0);
    cardEndOffset = Offset(widget.width, widget.clipSize);
    foldStartOffset = Offset(widget.clipSize, 0);
    foldEndOffset = Offset(0, widget.clipSize);
    angle = 0;
  }

  @override
  Widget build(BuildContext context) {
    final double MAX_TOP = -widget.height + cardSizeDiff + widget.clipSize;
    final double MAX_RIGHT = -widget.width - cardSizeDiff + widget.clipSize;
    return Stack(
      overflow: Overflow.visible,
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: CardClipper(
              startOffset: cardStartOffset, endOffset: cardEndOffset),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(10.0)),
            height: widget.height,
            width: widget.width,
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
          right: rightPos,
          top: topPos,
          child: Transform.rotate(
            angle: -PIVOT_ANGLE * 2,
            child: Transform.rotate(
              alignment: Alignment.topLeft,
              angle: angle,
              child: ClipPath(
                clipper: CardClipper(
                    startOffset: foldStartOffset,
                    endOffset: foldEndOffset,
                    isClipReverse: true),
                child: GestureDetector(
                  onVerticalDragStart: (DragStartDetails details) {},
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    double angleOfDisp;
                    if (details.localPosition.dy == 0.0) {
                      angleOfDisp = 0;
                    } else if (details.localPosition.dx == 0.0) {
                      angleOfDisp = PIVOT_ANGLE * 2;
                    } else {
                      double width = -details.localPosition.dy;
                      double height = -details.localPosition.dx;
                      double distance =
                          sqrt((width * width) + (height * height));
                      angleOfDisp = asin(width / distance);
                    }

                    double rotation = (angleOfDisp - PIVOT_ANGLE) * 2;
                    Offset topOffset = Offset(0.0, -details.localPosition.dx);
                    double topX = (cos(-rotation) * topOffset.dx) -
                        (sin(-rotation) * topOffset.dy);
                    double topY = (sin(-rotation) * topOffset.dx) +
                        (cos(-rotation) * topOffset.dy);
                    double gradientTop = topY / topX;
                    double x1 = ((topOffset.dy - topY) / gradientTop) + topX;
                    double topSize =
                        sqrt((x1 * x1) + (topOffset.dy * topOffset.dy));

                    Offset bottomOffset =
                        Offset(-details.localPosition.dy, 0.0);
                    double bottomX = (cos(-rotation) * bottomOffset.dx) -
                        (sin(-rotation) * bottomOffset.dy);
                    double bottomY = (sin(-rotation) * bottomOffset.dx) +
                        (cos(-rotation) * bottomOffset.dy);
                    double gradientBottom = bottomY / bottomX;
                    double y1 = (gradientBottom * (bottomOffset.dx - bottomX)) +
                        bottomY;
                    double bottomSize =
                        sqrt((y1 * y1) + (bottomOffset.dx * bottomOffset.dx));

                    if (details.localPosition.dx < 0.0 &&
                        details.localPosition.dy < 0.0) {
                      setState(() {
                        angle = rotation;
                        rightPos = -widget.height +
                            cardSizeDiff -
                            details.localPosition.dy;
                        topPos = -widget.height +
                            cardSizeDiff -
                            details.localPosition.dx;

                        cardStartOffset = Offset(
                            widget.width + details.localPosition.dy + x1, 0);
                        cardEndOffset = Offset(
                            widget.width, -details.localPosition.dx - y1);

                        foldStartOffset = Offset(topSize, 0);
                        foldEndOffset = Offset(0, bottomSize);
                      });
                    }
                  },
                  onVerticalDragEnd: (DragEndDetails details) {
                    setState(() {
                      rightPos = MAX_RIGHT;
                      topPos = MAX_TOP;
                      cardStartOffset =
                          Offset(widget.width - widget.clipSize, 0);
                      cardEndOffset = Offset(widget.width, widget.clipSize);
                      foldStartOffset = Offset(widget.clipSize, 0);
                      foldEndOffset = Offset(0, widget.clipSize);
                      angle = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10.0)),
                    height: widget.height,
                    width: widget.width,
                    child: Text("Some text"),
                  ),
                ),
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
  CardClipper(
      {@required this.startOffset,
      @required this.endOffset,
      this.isClipReverse = false});

  Offset startOffset;
  final Offset endOffset;
  final bool isClipReverse;
  @override
  Path getClip(Size size) {
    Path path = Path();
    if (isClipReverse) {
      //Top left
      path..moveTo(0.0, 0.0);
      // Bottom left
      // path..lineTo(0.0, startOffset.dy);
      // Top Right
      path..lineTo(startOffset.dx, startOffset.dy);
      path..lineTo(endOffset.dx, endOffset.dy);
      // Bottom right
      // path..lineTo(size.width, size.height);
    } else {
      // Bottom left
      path..moveTo(0.0, size.height);
      //Top left
      path..lineTo(0.0, startOffset.dy);
      // Top Right
      path..lineTo(startOffset.dx, startOffset.dy);
      path..lineTo(endOffset.dx, endOffset.dy);
      // Bottom right
      path..lineTo(size.width, size.height);
    }

    return path;
  }

  @override
  bool shouldReclip(CardClipper oldClipper) =>
      oldClipper.startOffset != startOffset ||
      oldClipper.endOffset != endOffset;
}
