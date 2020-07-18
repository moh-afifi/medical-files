import 'package:flutter/material.dart';

class ReusableColumnUpdate extends StatelessWidget {
  ReusableColumnUpdate({this.label,this.hintTextx,this.onChanged});
  final String label , hintTextx;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(color: Color(0xff888888), fontSize: 14),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          textAlign: TextAlign.end,
          onChanged: onChanged,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintTextx,
          ),
        ),
      ],
    );
  }
}
