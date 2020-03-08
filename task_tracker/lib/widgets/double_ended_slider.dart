import 'package:flutter/material.dart';

class DoubleEndedSlider extends StatefulWidget {
  final Function onUpdateLower;
  final Function onUpdateUpper;
  final bool isActive;
  DoubleEndedSlider(
      {@required this.onUpdateLower,
      @required this.onUpdateUpper,
      this.isActive = true});

  @override
  _DoubleEndedSliderState createState() => _DoubleEndedSliderState();
}

class _DoubleEndedSliderState extends State<DoubleEndedSlider> {
  static const _DOT_COUNT = 24;
  double _leftLimitPos = 0.0;
  double _rightLimitPos = 0.0;
  int _lowerBound = 0;
  int _upperBound = _DOT_COUNT;

  Color _getColor() {
    return widget.isActive ? Colors.white : Colors.grey[600];
  }

  Widget _buildDot(index) {
    bool isOutOfBounds = index <= _lowerBound || index >= _upperBound;
    Color color =
        isOutOfBounds || !widget.isActive ? Colors.grey[600] : Colors.white;

    return Container(
      width: 2.0,
      height: 2.0,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(20.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      children: <Widget>[
        Container(
          height: 30.0,
          child: Row(
            children: List.generate(_DOT_COUNT, (index) => _buildDot(index)),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
        Positioned(
          left: _leftLimitPos,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                double newPos = _leftLimitPos + details.primaryDelta;
                if (widget.isActive &&
                newPos + 20.0 < context.size.width &&
                    newPos > 0.0 &&
                    newPos + 10.0 < context.size.width - _rightLimitPos) {
                  _leftLimitPos += details.primaryDelta;
                  // Because the lower limit does not actually get to 2200h at
                  // the furthest point to the right, 5.0 is added so as to fix
                  // the 'margin of error'
                  _lowerBound = _leftLimitPos > 0.0
                      ? (((_leftLimitPos + 5.0) / context.size.width) * 24)
                          .floor()
                      : 0;

                  widget.onUpdateLower(_lowerBound);
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: _getColor(),
              ),
              width: 10.0,
              height: 30.0,
            ),
          ),
        ),
        Positioned(
          right: _rightLimitPos,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                double newPos = _rightLimitPos - details.primaryDelta;
                if (widget.isActive &&
                newPos + 10.0 < context.size.width &&
                    newPos > 0.0 &&
                    newPos + 10.0 < context.size.width - _leftLimitPos) {
                  _rightLimitPos -= details.primaryDelta;
                  _upperBound =
                      ((1 - (_rightLimitPos / context.size.width)) * 24)
                          .floor();

                  widget.onUpdateUpper(_upperBound);
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: _getColor(),
              ),
              width: 10.0,
              height: 30.0,
            ),
          ),
        ),
      ],
    ));
  }
}
