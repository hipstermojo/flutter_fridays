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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            '${_lowerLimit.toString()}:00',
            style:
                Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
          ),
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: Colors.white),
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
          onUpdateUpper: (newVal){
            setState(() {
              _upperLimit = newVal;
            });
          },
        ),
        Container(
          child: Text(
            '${_upperLimit.toString()}:00',
            style:
                Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
          ),
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: Colors.white),
            borderRadius: BorderRadius.circular(5.0),
          ),
          height: 30.0,
          width: 60.0,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 10.0),
        ),
      ],
    );
  }
}
