import 'package:flutter/material.dart';

class CustomChip extends StatefulWidget {
  final String category;

  CustomChip(this.category);
  @override
  _CustomChipState createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  bool _isActive = false;
  Color _getColor(Color activeColor, Color disabledColor) {
    return _isActive ? activeColor : disabledColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isActive = !_isActive;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: _getColor(Colors.white, Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
                width: 1.0, color: _getColor(Colors.white, Colors.grey[600]))),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        margin: EdgeInsets.only(right: 5.0, bottom: 5.0),
        child: Text(
          widget.category,
          style: Theme.of(context).textTheme.body1.copyWith(
              color:
                  _getColor(Theme.of(context).primaryColor, Colors.grey[600])),
        ),
      ),
    );
  }
}
