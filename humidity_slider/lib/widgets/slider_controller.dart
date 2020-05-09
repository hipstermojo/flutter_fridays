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
