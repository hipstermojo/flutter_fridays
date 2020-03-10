import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final TextStyle labelStyle;

  CustomChip(
      {@required this.label,
      @required this.backgroundColor,
      @required this.borderColor,
      @required this.labelStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(width: 1.0, color: borderColor)),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      margin: EdgeInsets.only(right: 5.0, bottom: 5.0),
      child: Text(
        label,
        style: labelStyle,
      ),
    );
  }
}
