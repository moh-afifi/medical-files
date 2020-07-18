import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class ReusableFileData extends StatelessWidget {
  ReusableFileData({this.fileName,this.fileDetails,this.delete,this.update,this.view,this.arabicDate});
  final String fileName, fileDetails,arabicDate;
  final Function delete , update ,view;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(arabicDate,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          SizedBox(height:10),
          GestureDetector(
            onTap: view,
            child: Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    DropdownButton(
                      icon: Icon(Icons.more_vert),
                      underline: Container(),
                      items: [
                        DropdownMenuItem(
                          value: 'edit',
                          child: Text(
                            'تعديل',
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'del',
                          child: Text(
                            'مسح',
                          ),
                        ),
                      ],
                      onChanged: (String value) {
                        switch (value) {
                          case 'edit':
                            update();
                            break;
                          case 'del':
                            delete();
                            break;
                        }
                      },
                    ),
                    Column(
                      children: <Widget>[
                        Text(fileName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                        SizedBox(height: 10,),
                        Text(fileDetails)
                      ],
                    ),
                    Icon(FontAwesomeIcons.fileMedicalAlt,size: 40,color: Colors.blueAccent,),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
