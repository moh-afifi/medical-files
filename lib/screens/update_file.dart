import 'package:flutter/material.dart';
import 'package:files/reusables/reusable_column_update.dart';
import 'package:files/reusables/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UpdateFile extends StatefulWidget {
  UpdateFile({this.docID, this.name, this.history, this.details});
  final String docID, name, history, details;
  @override
  _UpdateFileState createState() => _UpdateFileState();
}

class _UpdateFileState extends State<UpdateFile> {
  String name, type = 'إصابة', status = 'جاري', history, details;
  final _firestore = Firestore.instance;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'تعديل الملف',
          style:TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Builder(
          builder: (context) => ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
//-------------------------------------------------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        ReusableColumnUpdate(
                          label: 'اسم الملف',
                          hintTextx: widget.name,
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
//-------------------------------------------
                        Text(
                          'حالة الملف',
                          style:
                          TextStyle(color: Color(0xff888888), fontSize: 14),
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: Text('chooose'),
                          value: status,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (String newValue) {
                            setState(() {
                              status = newValue;
                            });
                          },
                          items: <String>['جاري', 'منتهي']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
//-------------------------------------------
                        Text(
                          'نوع الملف',
                          style:
                          TextStyle(color: Color(0xff888888), fontSize: 14),
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: Text('chooose'),
                          value: type,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (String newValue) {
                            setState(() {
                              type = newValue;
                            });
                          },
                          items: <String>['إصابة', 'مرض']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
//-------------------------------------------
                        ReusableColumnUpdate(
                          label: 'التاريخ',
                          hintTextx: widget.history,
                          onChanged: (value) {
                            history = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
//-------------------------------------------
                        ReusableColumnUpdate(
                          label: 'التفاصيل',
                          hintTextx: widget.details,
                          onChanged: (value) {
                            details = value;
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
//-------------------------------------------
                      ],
                    ),
                    RoundedButton(
                      onPressed: () async {

                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          print(widget.docID);
                          await _firestore
                              .collection('file')
                              .document(widget.docID)
                              .updateData({
                            'name': name,
                            'type': type,
                            'status': status,
                            'history': history,
                            'details': details,
                            'imageUrl': 'dsdsada'
                          });

//////////////////////////////////////////////////
                          new Future.delayed(new Duration(seconds: 2), () {
                            setState(() {
                              showSpinner = false;
                            });
//-----------------------
                            Scaffold.of(context).showSnackBar(new SnackBar(
                              backgroundColor: Colors.teal,
                              duration: Duration(seconds: 3),
                              content: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.thumb_up,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("تم إرسال البيانات !"),
                                ],
                              ),
                            ));
                          });
                        } catch (e) {
                          new Future.delayed(new Duration(seconds: 3), () {
                            setState(() {
                              showSpinner = false;
                            });
//-----------------------
                            Scaffold.of(context).showSnackBar(new SnackBar(
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                              content: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.thumb_down,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("يجب ادخال كل البيانات"),
                                ],
                              ),
                            ));
                          });
                        }
                      },
                      colour: Color(0xff021432),
                      title: 'تعديل',
                    )
                  ],
                ),
              ))),
    );
  }
}
