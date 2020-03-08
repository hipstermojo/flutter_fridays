import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasktracker/widgets/double_ended_slider.dart';

class TimeRange extends StatefulWidget {
  @override
  _TimeRangeState createState() => _TimeRangeState();

  TimeRange();
}

class _TimeRangeState extends State<TimeRange> {
  int _lowerLimit = 0;
  int _upperLimit = 23;
  bool _isActive = false;

  Color _getColor() {
    return _isActive ? Colors.white : Colors.grey[600];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Time range',
              style: Theme.of(context).textTheme.title,
            ),
            CupertinoSwitch(
              activeColor: Colors.grey[600],
              value: _isActive,
              onChanged: (value) {
                setState(() {
                  _isActive = value;
                  print(_isActive);
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          children: <Widget>[
            Container(
              child: Text(
                '${_lowerLimit.toString()}:00',
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: _getColor()),
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: _getColor()),
                borderRadius: BorderRadius.circular(5.0),
              ),
              height: 30.0,
              width: 60.0,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 10.0),
            ),
            DoubleEndedSlider(
              onUpdateLower: (newVal) {
                setState(() {
                  _lowerLimit = newVal;
                });
              },
              onUpdateUpper: (newVal) {
                setState(() {
                  _upperLimit = newVal;
                });
              },
              isActive: _isActive,
            ),
            Container(
              child: Text(
                '${_upperLimit.toString()}:00',
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: _getColor()),
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: _getColor()),
                borderRadius: BorderRadius.circular(5.0),
              ),
              height: 30.0,
              width: 60.0,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10.0),
            ),
          ],
        ),
      ],
    );
  }
}
