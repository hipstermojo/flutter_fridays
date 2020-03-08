import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String day;

  CustomButton(this.day);
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
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
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1.0, color: _getColor(Colors.white, Colors.grey[600])),
          borderRadius: BorderRadius.circular(5.0),
          color: _getColor(Colors.white, Theme.of(context).primaryColor),
        ),
        child: Text(
          widget.day,
          style: Theme.of(context).textTheme.body1.copyWith(
              color:
                  _getColor(Theme.of(context).primaryColor, Colors.grey[600])),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
