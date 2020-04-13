import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Dial extends StatefulWidget {
  final Function onUpdate;
  final Function onStart;
  final Function onComplete;
  // TODO: Change from using integers to using a "range" construct or enumeration
  final int from;
  final int to;
  Dial({this.onUpdate, this.from, this.to, this.onStart, this.onComplete});
  @override
  _DialState createState() => _DialState();
}

class _DialState extends State<Dial> with SingleTickerProviderStateMixin {
  int _current = 0;
  Offset startPoint = Offset.zero;
  AnimationController _controller;
  Animation _animation;
  static final Duration _duration = Duration(milliseconds: 2000);
  final double delay = 500 / _duration.inMilliseconds;
  bool isAnimating = false;
  int _oldCurrent;

  @override
  void initState() {
    super.initState();
    _oldCurrent = 0;
    _controller = AnimationController(duration: _duration, vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(delay, 1.0, curve: Curves.easeInOutSine)))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          setState(() {
            isAnimating = false;
            widget
                .onComplete(_getMarkedValue(_current, widget.from, widget.to));
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _angleDivision = 360 / (widget.to - widget.from + 1);
    double angleDivisionRadians = (_angleDivision / 180 * pi);

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        return AnimatedBuilder(
          animation: _controller,
          child: Center(
            child: IgnorePointer(
              ignoring: isAnimating,
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

                  setState(() {
                    if (angleTurned >= angleDivisionRadians) {
                      if (_isClockwise(
                          height, height, startPoint, currentPoint)) {
                        _current = _current < widget.to - widget.from
                            ? _current + 1
                            : 0;
                      } else {
                        _current = _current > 0
                            ? _current - 1
                            : widget.to - widget.from;
                      }
                      widget.onUpdate(
                          _getMarkedValue(_current, widget.from, widget.to));
                      startPoint = currentPoint;
                    }
                  });
                },
                onHorizontalDragEnd: (_) {
                  if (_oldCurrent != _current) {
                    _controller.forward();
                    widget.onStart();
                    setState(() {
                      isAnimating = true;
                      _oldCurrent = _current;
                    });
                  }
                },
                child: Container(
                  height: height,
                  width: height,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          builder: (context, child) {
            return CustomPaint(
              child: child,
              painter: DialFace(
                start: widget.from,
                stop: widget.to,
                current: _current,
                animRatio: _animation.value,
              ),
            );
          },
        );
      },
    );
  }
}

int _getMarkedValue(int current, int from, int to) {
  int value;
  if (current == 0) {
    value = from;
  } else {
    value = from + (to - current) - 1;
  }
  return value;
}

/// Determines if a rotation is clockwise
bool _isClockwise(double height, double width, Offset start, Offset current) {
  bool result;

  /// Evaluate the left half
  if (start.dx < width / 2 && current.dx < width / 2) {
    if (start.dy < width / 2 && current.dy < width / 2) {
      result = start.dx < current.dx && start.dy > current.dy;
    } else {
      result = start.dx > current.dx && start.dy > current.dy;
    }
  } else {
    if (start.dy < width / 2 && current.dy < width / 2) {
      result = start.dx < current.dx && start.dy < current.dy;
    } else {
      result = start.dx > current.dx && start.dy < current.dy;
    }
  }
  return result;
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
  final animRatio;

  DialFace({
    this.start,
    this.stop,
    this.current,
    this.animRatio,
  });
  final Paint circlePainter = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.black
    ..isAntiAlias = true;

  final Paint dialMarkPainter = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.green
    ..strokeWidth = 0.5;

  final TextPainter textPainter = TextPainter()
    ..textDirection = TextDirection.ltr;

  final Paint arcPainter = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.grey
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final fontSize = radius > 150 ? 13.0 : 10.0;
    double distanceToBorder = center.dx - radius;
    canvas.drawCircle(center, radius - 2, circlePainter);

    circlePainter..style = PaintingStyle.fill;
    canvas.drawCircle(center, 5.0, circlePainter);
    circlePainter..style = PaintingStyle.stroke;

    var count = stop - start + 1;
    var padding = 5;
    double centerOffset = ((size.height - size.width) / 2).abs();
    for (var i = 0; i < count; i++) {
      canvas.save();
      // Angle is given in radians
      var angle = 2 * pi * (i + current) / count;
      textPainter.text = new TextSpan(
          text: (start + i).toString(),
          style: TextStyle(color: Colors.black, fontSize: fontSize));

      // Translate plots where to place the text using coordinates x and y given
      // x = radius + radius * cos(theta), y = radius + radius * sin(theta),
      // where theta is the angle you want to plot to. However this draws from
      // the right (at the 3 o' clock hour hand) which is not what this dial
      // should look like. Therefore to have it draw from the 9 o' clock hour
      // hand, cos(theta) becomes -cos(theta) and sin(theta) becomes -sin(theta)
      canvas.translate(
          radius +
              radius * -cos(angle) +
              (size.width > size.height ? centerOffset : 0),
          radius +
              radius * -sin(angle) +
              (size.height > size.width ? centerOffset : 0));
      // Rotate the canvas which then rotates the text that will be drawn
      canvas.rotate(angle);
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(
              // Adjust the text to aligned with the green marker
              (textPainter.height / 2) + padding,
              (textPainter.height / 2) - 10));

      canvas.restore();
    }

    canvas.drawCircle(
        Offset(
            distanceToBorder +
                (textPainter.width * 2) +
                (2 * padding) +
                (0.1 * radius),
            center.dy),
        0.1 * radius,
        dialMarkPainter);
    dialMarkPainter
      ..style = PaintingStyle.stroke
      ..color = Colors.black;
    canvas.drawCircle(
        Offset(
            distanceToBorder +
                (textPainter.width * 2) +
                (2 * padding) +
                (0.1 * radius),
            center.dy),
        0.1 * radius,
        dialMarkPainter);
    dialMarkPainter
      ..style = PaintingStyle.fill
      ..color = Colors.green;

    canvas.drawArc(
        Rect.fromCircle(
            center: center,
            radius: radius - (textPainter.width * 2) - (padding)),
        pi * (1.5 + (4 * animRatio)),
        pi * _getArcSweep(animRatio, 3 / 5),
        false,
        arcPainter);
  }

  /// timeRatio refers to the ratio of the timeline elapsed.
  /// maxArcRatio refers to the ratio of the arc at its longest relative to its
  /// circle.
  /// Returns the ratio of the sweep angle of the arc. Specifically,
  /// it works by increasing the size of the angle in the first quarter of an
  /// animation timeline and decreasing the size of the angle in the last quarter
  /// of an animation timeline. The rest of the time, the arc remains the size.
  double _getArcSweep(double timeRatio, double maxArcRatio) {
    double length = maxArcRatio;
    if (timeRatio <= 0.25) {
      length = timeRatio / 0.25 * maxArcRatio;
    } else if (timeRatio >= 0.75) {
      length = (1 - timeRatio) / 0.25 * maxArcRatio;
    }
    return length;
  }

  @override
  bool shouldRepaint(DialFace oldDelegate) {
    return oldDelegate.current != current || oldDelegate.animRatio != animRatio;
  }
}
