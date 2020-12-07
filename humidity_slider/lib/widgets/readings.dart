import 'package:flutter/material.dart';

class Readings extends StatelessWidget {
  const Readings({
    Key key,
  }) : super(key: key);

  static const List<int> _readings = [0, 10, 25, 30, 35, 40, 45, 50, 75, 100];
  static const int _LOWER_HUMIDITY_LIMIT = 30;
  static const int _UPPER_HUMIDITY_LIMIT = 50;
  static const double BOTTOM_MARGIN = 30.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: BOTTOM_MARGIN),
      child: FractionallySizedBox(
        heightFactor: 0.85,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _readings
                .map((reading) => Container(
                      child: Row(
                        children: <Widget>[
                          extremeIndicator(reading),
                          Text(
                            reading.toString() + "%",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ))
                .toList()
                .reversed
                .toList()),
      ),
    );
  }

  Container extremeIndicator(int reading) {
    return Container(
        margin: EdgeInsets.only(left: 10.0, right: 5.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: reading >= _LOWER_HUMIDITY_LIMIT &&
                    reading < _UPPER_HUMIDITY_LIMIT
                ? Colors.transparent
                : Colors.yellow),
        height: 4.0,
        width: 4.0);
  }
}
