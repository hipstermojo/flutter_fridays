import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Dial extends StatefulWidget {
  @override
  _DialState createState() => _DialState();
}

class _DialState extends State<Dial> {
  int _current = 0;
  static int _from = 2;
  static int _to = 25;
  Offset startPoint = Offset.zero;
  static double _angleDivision = 360 / (_to - _from + 1);
  double angleDivisionRadians = (_angleDivision / 180 * pi);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        return Stack(
          children: <Widget>[
            CustomPaint(
              child: Center(
                child: GestureDetector(
                  onHorizontalDragStart: (details) {
                    startPoint = details.localPosition;
                  },
                  onHorizontalDragUpdate: (details) {
                    Offset currentPoint = details.localPosition;


                    double angleTurned = _computeTurnAngle(
                        Offset(height / 2, height / 2),
                        startPoint,
                        currentPoint,
                        height / 2);

                    if(angleTurned<0.0){
                      print("Turned negative");
                    }
                    setState(() {
                      if (angleTurned >= angleDivisionRadians) {
                        _current = (_current + 1) % (_to - 1);
                        startPoint = currentPoint;
                      }
                    });
                  },

                  child: Container(
                    height: height,
                    width: height,
                    color: Color(0x00000000),
                  ),
                ),
              ),
              painter: DialFace(start: _from, stop: _to, current: _current),
            ),
          ],
        );
      },
    );
  }
}

/// Returns the angle in radians between two points in a circle
/// Works by getting the chord length between the two points and then calculating
/// the angle subtended by that arc length in radians using the formula
/// theta = 2 * asin(chord/(2*radius)) where theta is the angle subtended, asin
/// is the sine inverse.
double _computeTurnAngle(
    Offset center, Offset startPoint, Offset currentPoint, double radius) {
  var startPointOnCircumference =
      _pointOnCircumference(center, startPoint, radius);
  var currentPointOnCircumference =
      _pointOnCircumference(center, currentPoint, radius);
  double chordLength = _euclideanDistance(
      startPointOnCircumference, currentPointOnCircumference);

  return 2 * asin(chordLength / (2 * radius));
}

/// _pointOnCircumference works by taking in a coordinate acting as the origin
/// and another coordinate as the target point. It then calculates the gradient
/// between the two.
///
/// Using the gradient and given radius, it computes the coordinates on the circumference
/// using the following calculations
/// x coordinate: radius/sqrt(gradient^2 + 1)
/// y coordinate: (gradient * radius)/sqrt(gradient^2 + 1)
Offset _pointOnCircumference(Offset origin, Offset point, double radius) {
  double dx = origin.dx - point.dx;
  double dy = origin.dy - point.dy;
  double gradient = dy / dx;
  double pointX = radius / sqrt((pow(gradient, 2) + 1));
  double pointY = (gradient * radius) / sqrt((pow(gradient, 2) + 1));
  return Offset(pointX, pointY);
}

double _euclideanDistance(Offset pointA, Offset pointB) {
  var dx = pointA.dx - pointB.dx;
  var dy = pointA.dy - pointB.dy;

  var dxSquared = pow(dx, 2);
  var dySquared = pow(dy, 2);
  return sqrt(dxSquared + dySquared);
}

class DialFace extends CustomPainter {
  final start;
  final stop;
  // The variable current is used to denote the currently marked number on the dial
  final current;
  DialFace({this.start, this.stop, this.current = -2});
  final Paint circlePainter = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.black
    ..isAntiAlias = true;

  final TextPainter textPainter = TextPainter()
    ..textDirection = TextDirection.ltr;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.height / 2;
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius - 2, circlePainter);
    circlePainter..style = PaintingStyle.fill;
    // TODO: Set coordinates for green circle to be consistent across screens
    canvas.drawCircle(center, 5.0, circlePainter);
    circlePainter..color = Colors.green;
    canvas.drawCircle(
        Offset(radius, size.height / 2), 0.1 * radius, circlePainter);

    var count = stop - start + 1;
    var padding = 5;
    for (var i = 0; i < count; i++) {
      canvas.save();
      // Angle is given in radians
      var angle = 2 * pi * (i + current) / count;
      textPainter.text = new TextSpan(
          text: (start + i).toString(),
          style: TextStyle(color: Colors.black, fontSize: 10.0));
      var distanceToBorder = (size.width - size.height) / 2;

      // Translate plots where to place the text using coordinates x and y given
      // x = radius + radius * cos(theta), y = radius + radius * sin(theta),
      // where theta is the angle you want to plot to. However this draws from
      // the right (at the 3 o' clock hour hand) which is not what this dial
      // should look like. Therefore to have it draw from the 9 o' clock hour
      // hand, cos(theta) becomes -cos(theta) and sin(theta) becomes -sin(theta)
      canvas.translate(radius + radius * -cos(angle) + distanceToBorder,
          radius + radius * -sin(angle));
      // Rotate the canvas which then rotates the text that will be drawn
      canvas.rotate(angle);
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(
              (textPainter.height / 2) + padding, (textPainter.height / 2) - 10)
          // Adjust the text to aligned with the green marker
          );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(DialFace oldDelegate) {
    return oldDelegate.current != current;
  }
}
