import 'package:flutter/material.dart';


class ReusableFileTextField extends StatelessWidget {

  ReusableFileTextField({this.title,this.hint,this.onChanged});
  final String title , hint ;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: Color(0xff888888), fontSize: 14),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          onChanged: onChanged,
          textAlign: TextAlign.end,
          decoration: InputDecoration(
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
