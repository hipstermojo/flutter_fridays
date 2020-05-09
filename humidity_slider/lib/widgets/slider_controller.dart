import 'package:flutter/material.dart';
import 'package:humidity_slider/widgets/readings.dart';

class SliderController extends StatefulWidget {
  const SliderController({
    Key key,
  }) : super(key: key);

  @override
  _SliderControllerState createState() => _SliderControllerState();
}

class _SliderControllerState extends State<SliderController> {
  static const double controllerRadius = 20.0;
  double yPos = Readings.BOTTOM_MARGIN - controllerRadius;
  double bottomMargin = Readings.BOTTOM_MARGIN;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final xPos = constraints.maxWidth * 0.2;
      double upperBound = (constraints.maxHeight * 0.15) + controllerRadius;
      double lowerBound =
          constraints.maxHeight - bottomMargin + controllerRadius;
      return Stack(
        children: <Widget>[
          Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: CustomPaint(
              painter: LinePainter(
                  controllerPos: Offset(xPos, lowerBound - yPos),
                  controllerRadius: controllerRadius),
            ),
          ),
          Positioned(
            right: xPos,
            bottom: yPos,
            child: GestureDetector(
              onVerticalDragUpdate: (DragUpdateDetails details) {
                if (details.globalPosition.dy > upperBound &&
                    details.globalPosition.dy < lowerBound) {
                  setState(() {
                    yPos -= details.delta.dy;
                  });
                }
              },
              child: CircleAvatar(
                radius: controllerRadius,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.unfold_more,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class LinePainter extends CustomPainter {
  LinePainter({this.controllerPos, this.controllerRadius});

  final Offset controllerPos;
  final double controllerRadius;
  static const Color _redGradient = Color(0xff560920);
  static const Color _blueGradient = Color(0xff2b6799);
  static const double curveMargin = 10.0;
  @override
  void paint(Canvas canvas, Size size) {
    final double midX = size.width / 2;
    final Paint linePainter = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          _redGradient,
          _blueGradient,
          _redGradient,
        ],
        stops: [0.2, 0.6, 1.0],
      ).createShader(Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          height: size.height,
          width: 5.0))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    canvas.drawLine(
        Offset(midX, 0),
        Offset(midX, controllerPos.dy - controllerRadius - curveMargin * 2),
        linePainter);

    canvas.drawLine(Offset(midX, controllerPos.dy + controllerRadius),
        Offset(midX, size.height), linePainter);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return controllerPos != oldDelegate.controllerPos;
  }
}
