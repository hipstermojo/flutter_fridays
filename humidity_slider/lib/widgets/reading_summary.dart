import 'package:flutter/material.dart';

class ReadingSummary extends StatelessWidget {
  const ReadingSummary({
    Key key,
  }) : super(key: key);

  static const TextStyle boldTextStyle = TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0);
  static const TextStyle titleStyle =
      TextStyle(color: Color(0x80ffffff), fontSize: 10.0);
  final double smallMargin = 10.0;
  final double largeMargin = 30.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          alignment: Alignment.topRight,
          child: Icon(
            Icons.more_horiz,
            color: Colors.white,
          ),
        ),
        Spacer(),
        Text(
          "Return Temperature".toUpperCase(),
          style: titleStyle,
        ),
        SizedBox(
          height: smallMargin,
        ),
        Text(
          "20°C",
          style: boldTextStyle,
        ),
        SizedBox(
          height: largeMargin,
        ),
        Text(
          "Current Humidity".toUpperCase(),
          style: titleStyle,
        ),
        SizedBox(
          height: smallMargin,
        ),
        Text(
          "37%",
          style: boldTextStyle.copyWith(fontSize: 60.0),
        ),
        SizedBox(
          height: largeMargin,
        ),
        Text(
          "Absolute Humidity".toUpperCase(),
          style: titleStyle,
        ),
        SizedBox(
          height: smallMargin,
        ),
        Text(
          "4gr/ft3",
          style: boldTextStyle,
        ),
        SizedBox(
          height: largeMargin,
        ),
        Icon(
          Icons.warning,
          color: Colors.yellow,
        ),
        SizedBox(
          height: smallMargin,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 5.0,
              width: 5.0,
              decoration:
                  BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
            ),
            Container(
              height: 1.0,
              width: 5.0,
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
            ),
            Text(
              "extreme humidity levels.",
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            ),
          ],
        ),
        Text(
          "Use precaution for set-points outside of 20%-55%.",
          style: TextStyle(fontSize: 10.0),
        ),
        SizedBox(
          height: 40.0,
        ),
      ],
    );
  }
}
