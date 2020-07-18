import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();
    rightPos = -widget.width + widget.clipSize;
    topPos = -widget.height + widget.clipSize;
    cardStartOffset = Offset(widget.width - widget.clipSize, 0);
    cardEndOffset = Offset(widget.width, widget.clipSize);
    foldStartOffset = Offset(0, widget.height - widget.clipSize);
    foldEndOffset = Offset(widget.clipSize, widget.height);
  }

  @override
  Widget build(BuildContext context) {
    final double MAX_TOP = -widget.height + widget.clipSize;
    final double MAX_RIGHT = -widget.width + widget.clipSize;
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
            angle: 0,
            child: ClipPath(
              clipper: CardClipper(
                  startOffset: foldStartOffset, endOffset: foldEndOffset),
              child: GestureDetector(
                onVerticalDragStart: (DragStartDetails details) {},
                onVerticalDragUpdate: (DragUpdateDetails details) {
                  if (-widget.width - details.localPosition.dx >= MAX_RIGHT ||
                      -(widget.height * 2) + details.localPosition.dy >=
                          MAX_TOP) {
                    setState(() {
                      rightPos = -widget.width - details.localPosition.dx;
                      topPos = -(widget.height * 2) + details.localPosition.dy;
                      cardStartOffset =
                          Offset(widget.width + details.localPosition.dx, 0);
                      cardEndOffset = Offset(widget.width,
                          details.localPosition.dy - widget.height);
                      foldStartOffset = Offset(0, -topPos);
                      foldEndOffset =
                          Offset(-details.localPosition.dx, widget.height);
                    });
                  }
                },
                onVerticalDragEnd: (DragEndDetails details) {
                  setState(() {
                    rightPos = MAX_RIGHT;
                    topPos = MAX_TOP;
                    cardStartOffset = Offset(widget.width - widget.clipSize, 0);
                    cardEndOffset = Offset(widget.width, widget.clipSize);
                    foldStartOffset =
                        Offset(0, widget.height - widget.clipSize);
                    foldEndOffset = Offset(widget.clipSize, widget.height);
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
