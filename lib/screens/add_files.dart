import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../reusables/reusable_file_text_field.dart';
import '../reusables/reusable_file_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../reusables/rounded_button.dart';
import 'add_appointment.dart';
import 'add_medicine.dart';
import 'package:files/screens/retrieve_files.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
//-----------------------------------------------
class AddFiles extends StatefulWidget {
  @override
  _AddFilesState createState() => _AddFilesState();
}

class _AddFilesState extends State<AddFiles> {

//---------------------------------------------------
  String fileType = 'إصابة', fileStatus = 'جاري';
  String fileName, history, fileDetails, id;
  String medName, medDuration, medDetails,imageName =' ';
  String fileUrl, imageUrl, fileKind,arabicDate;
  final _fireStore = Firestore.instance;
  bool showSpinner = false;
  File _image;
  File _file;
  bool isImage = true , isRow1 =false,isRow2 =false;
//--------------------------------------------------
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      isImage = true;
    });
  }

  //==========================
  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    setState(() {
      showSpinner = true;
    });
    await uploadTask.onComplete;
    String downloadAddress = await firebaseStorageRef.getDownloadURL();
    imageUrl = downloadAddress;
    setState(() {
      showSpinner = false;
    });
  }

  //------------------------------------------------
  Future filePicker() async {
    File file = await FilePicker.getFile(type: FileType.any,);

    setState(() {
      _file = file;
      isImage = false;
    });
  }
  //-------------------------------------------------------

  Future uploadFile(BuildContext context) async {
    String fileName = basename(_file.path);
    StorageReference storageReference;

    storageReference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = storageReference.putFile(_file);
    setState(() {
      showSpinner = true;
    });

    await uploadTask.onComplete;
    String downloadAddress = await storageReference.getDownloadURL();
    fileUrl = downloadAddress;
    setState(() {
      showSpinner = false;
    });
  }

  //------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'إضافة ملف طبي',
            style: TextStyle(color: Colors.black, fontSize: 20),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              height: 25,
                            ),
                            //---------------------------------------
                            ReusableFileTextField(
                              title: '*اسم الملف:',
//                          hint: 'ادخل اسم الملف..',
                              onChanged: (value) {
                                fileName = value;
                              },
                            ),
                            //--------------------------------------
                            SizedBox(
                              height: 30,
                            ),
                            //--------------------------------------
                            Text(
                              '*نوع الملف',
                              style:
                              TextStyle(color: Color(0xff888888), fontSize: 14),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            DropdownButton<String>(
                              isExpanded: true,
                              hint: Text('chooose'),
                              value: fileType,
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              onChanged: (String newValue) {
                                setState(() {
                                  fileType = newValue;
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
                            //------------------------------------------------------------------
                            SizedBox(
                              height: 30,
                            ),
                            //--------------------------------------
                            Text(
                              '*حالة الملف:',
                              style:
                              TextStyle(color: Color(0xff888888), fontSize: 14),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            DropdownButton<String>(

                              isExpanded: true,
                              hint: Text('chooose'),
                              value: fileStatus,
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              onChanged: (String newValue) {
                                setState(() {
                                  fileStatus = newValue;
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
                            //------------------------------------------------------------------
                            SizedBox(
                              height: 30,
                            ),
                            ReusableFileTextField(
                              title: '*التاريخ:',
//                          hint: 'أدخل التاريخ..',
                              onChanged: (value) {
                                history = value;
                              },
                            ),
                            //--------------------------------------
                            SizedBox(
                              height: 30,
                            ),
                            ReusableFileTextField(
                              title: '*التفاصيل:',
//                          hint: 'enter details ..',
                              onChanged: (value) {
                                fileDetails = value;
                              },
                            ),
                            //--------------------------------------
                            SizedBox(
                              height: 20,
                            ),
                            //---------------------------------------
                            ReusableFileCard(
                              close: (){
                                setState(() {
                                  isRow1=false;
                                });
                              },
                              isRow: isRow1,
                              itemName: medName,
                              label: 'الأدوية',
                              txt: 'إضافة دواء+',
                              icon: FontAwesomeIcons.pills,
                              onTap: () {
                                //if fileStatus == 'valid' , navigate to add medicine in alerts page:
                                //if fileStatus == 'expired' , :

                                (fileStatus == 'منتهي')
                                    ? showDialog(
                                    context: context,
                                    builder: (_) => new AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      content: Builder(
                                        builder: (context) {
// Get available height and width of the build area of this widget. Make a choice depending on the size.
                                          var height =
                                              MediaQuery.of(context)
                                                  .size
                                                  .height;
                                          var width = MediaQuery.of(context)
                                              .size
                                              .width;

                                          return Container(
                                            height: height - 300,
                                            width: width - 100,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                              children: <Widget>[
                                                ReusableFileTextField(
                                                  title: 'اسم الدواء',
//                                                  hint: 'ادخل اسم الدواء..',
                                                  onChanged: (value) {
                                                    medName = value;
                                                  },
                                                ),
                                                ReusableFileTextField(
                                                  title:
                                                  'مدة الدواء بالأيام',
//                                                  hint: 'أدخل مدة الدواء..',
                                                  onChanged: (value) {
                                                    medDuration = value;
                                                  },
                                                ),
                                                ReusableFileTextField(
                                                  title: 'التفاصيل',
//                                                  hint: 'أدخل القفاصيل..',
                                                  onChanged: (value) {
                                                    medDetails = value;
                                                  },
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: <Widget>[
                                                    FlatButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          isRow1=true;
                                                        });
                                                        _fireStore
                                                            .collection(
                                                            'med')
                                                            .add({
                                                          'name': medName,
                                                          'type':
                                                          medDuration,
                                                          'details':
                                                          medDetails,
                                                        });
                                                        Navigator.pop(
                                                            context);
                                                      },
                                                      child: Text(
                                                        'موافق',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white,
                                                            fontSize: 15),
                                                      ),
                                                      color: Colors.teal,
                                                    ),
                                                    FlatButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context);
                                                      },
                                                      child: Text(
                                                        'إلغاء',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white,
                                                            fontSize: 15),
                                                      ),
                                                      color: Colors.red,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ))
                                    : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddMedicine(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            (fileStatus == 'جاري')
                                ? ReusableFileCard(
                              label: 'حجز عند طبيب',
                              txt: 'إضافة حجز+',
                              icon: FontAwesomeIcons.fileAlt,
                              onTap: () {
                                //navigate to add booking screen in alerts page:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddAppointment(),
                                  ),
                                );
                              },
                            )
                                : SizedBox(),
                            SizedBox(
                              height: 20,
                            ),
                            //---------------------------------------
                            ReusableFileCard(
                              isRow: isRow2,
                              close: () {
                                setState(() {
                                  isRow2=false;
                                });
                              },
                              itemName: imageName,
                              label: 'الملفات',
                              txt: 'إضافة صور أو ملفات+',
                              icon: FontAwesomeIcons.file,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => new AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      content: Builder(
                                        builder: (context) {
// Get available height and width of the build area of this widget. Make a choice depending on the size.
                                          var height = MediaQuery.of(context)
                                              .size
                                              .height;
                                          var width =
                                              MediaQuery.of(context).size.width;

                                          return Container(
                                              height: height - 750,
                                              width: width - 200,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: <Widget>[
                                                  GestureDetector(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Image.asset(
                                                          'images/gallery.png',
                                                          height: 50,
                                                          width: 50,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          'صور',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueAccent),
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () async{
                                                       await getImage();
                                                      setState(() {
                                                        fileKind = 'image';
                                                        (_image!=null)? imageName=basename(_image.path): imageName ='fileName';
//                                                      imageName=basename(_image.path);
                                                        isRow2=true;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  //-----------------------------------
                                                  GestureDetector(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Image.asset(
                                                          'images/pdf.png',
                                                          height: 50,
                                                          width: 50,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          'ملفات',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueAccent),
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () async{

                                                      await filePicker();

                                                       setState(() {
                                                        fileKind = 'pdf';
                                                        (_file!=null)? imageName=basename(_file.path): imageName ='';
//                                                      imageName=basename(_image.path);
                                                         isRow2=true;
                                                      });

                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              ));
                                        },
                                      ),
                                    ));
                              },
                            ),
                            //---------------------------------------
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        RoundedButton(
                          title: 'إضافة',
                          colour: Color(0xff021432),
                          onPressed: () async {

                            initializeDateFormatting("ar", null).then((_) {
                              var now = DateTime.now();
                              var formatter = DateFormat.yMd('ar');
                              String formatted = formatter.format(now);
                              arabicDate=formatted;
                              print(arabicDate);
                            });
                            //-------------------------------
                            setState(() {
                              showSpinner = true;
                            });


                            if (isImage) {
                              await uploadPic(context);

                              DocumentReference docRef =
                              await _fireStore.collection('file').add({
                                'name': fileName,
                                'type': fileType,
                                'status': fileStatus,
                                'history': history,
                                'details': fileDetails,
                                'imageUrl': imageUrl,
                                'fileKind': fileKind,
                                'arabicDate':arabicDate
                              });

                              //-------------------------------------
                              print(imageUrl);
                              setState(() {
                                showSpinner = false;
                                id = docRef.documentID;
                              });
                              //------------------------------------
                            } else if (!isImage) {
                              DocumentReference docRef =await _fireStore.collection('file').add({
                                'name': fileName,
                                'type': fileType,
                                'status': fileStatus,
                                'history': history,
                                'details': fileDetails,
                                'fileUrl': fileUrl,
                                'fileKind': fileKind,
                                'arabicDate':arabicDate
                              });
                              //----------------------------
                              await uploadFile(context);
                              print(fileUrl);
                              setState(() {
                                showSpinner = false;
                                id = docRef.documentID;
                              });
                            }
                            showDialog(
                                context: context,
                                builder: (_) => new AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  content: Builder(
                                    builder: (context) {
                                      var height = MediaQuery.of(context)
                                          .size
                                          .height;
                                      var width = MediaQuery.of(context)
                                          .size
                                          .width;

                                      return Container(
                                        height: height - 700,
                                        width: width - 200,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceEvenly,
                                          children: <Widget>[
                                            Center(
                                              child: Text(
                                                'تم إرسال البيانات',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.teal),
                                              ),
                                            ),
                                            FlatButton(
                                              child: Text(
                                                'موافق',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () async {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RetrieveFiles(
                                                          docID: id,
                                                        ),
                                                  ),
                                                );
                                                //--------------------------------------------
                                              },
                                              color: Colors.teal,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ));
                            //--------------------------------------------------
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
//----------------------------------------------
