import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.title, this.colour, @required this.onPressed});

  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: colour,
      borderRadius: BorderRadius.circular(15.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 150.0,
        height: 42.0,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15
          ),
        ),
      ),
    );
  }
}