import 'package:flutter/material.dart';
import 'package:tasktracker/widgets/custom_chip.dart';

class CustomActionChip extends StatefulWidget {
  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final TextStyle labelStyle;
  final Function onPressed;
  CustomActionChip(
      {@required this.label,
      @required this.backgroundColor,
      @required this.borderColor,
      @required this.labelStyle,
      @required this.onPressed});

  @override
  _CustomActionChipState createState() => _CustomActionChipState();
}

class _CustomActionChipState extends State<CustomActionChip> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: CustomChip(
        label: widget.label,
        backgroundColor: widget.backgroundColor,
        borderColor: widget.borderColor,
        labelStyle: widget.labelStyle,
      ),
    );
  }
}
