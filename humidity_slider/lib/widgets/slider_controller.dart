import 'package:flutter/material.dart';

class SliderController extends StatefulWidget {
  const SliderController({
    Key key,
  }) : super(key: key);

  @override
  _SliderControllerState createState() => _SliderControllerState();
}

class _SliderControllerState extends State<SliderController> {
  double yPos = 10.0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: <Widget>[
          Container(
            height: constraints.maxHeight,
          ),
          Positioned(
            right: 15,
            bottom: yPos,
            child: GestureDetector(
              onVerticalDragUpdate: (DragUpdateDetails details) {
                if (details.globalPosition.dy > 50.0 &&
                    details.globalPosition.dy <
                        (constraints.maxHeight - 25.0)) {
                  setState(() {
                    yPos -= details.delta.dy;
                  });
                }
              },
              child: Container(
                height: 35.0,
                width: 35.0,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
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
