import 'package:flutter/material.dart';

class ReusableFileCard extends StatelessWidget {
  ReusableFileCard(
      {this.label,
      this.icon,
      this.txt,
      this.onTap,
      this.itemName,
      this.isRow,
      this.close});
  final String label, txt, itemName;
  final IconData icon;
  final Function onTap, close;
  final bool isRow;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    label,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    icon,
                    color: Colors.black,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              (isRow == true)
                  ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                onPressed: close,
                                icon: Icon(Icons.close, color: Colors.red),
                              ),
                              Text(itemName ,style: TextStyle(fontSize: 13,),)
                            ],
                          ),
                        ),
                      ),
                  )
                  : SizedBox(),
              SizedBox(
                height: 15,
              ),
              //------------------------------------------------------
              Text(
                txt,
                style: TextStyle(fontSize: 14, color: Color(0xFF2E8CDD)),
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
