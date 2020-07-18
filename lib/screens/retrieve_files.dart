import 'package:files/reusables/reusable_file_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:files/screens/home_page.dart';
import 'package:files/screens/add_files.dart';
import 'update_file.dart';
import 'pdf_view.dart';
import 'image_view.dart';

class RetrieveFiles extends StatefulWidget {
  RetrieveFiles({this.docID});
  final String docID;
  @override
  _RetrieveFilesState createState() => _RetrieveFilesState();
}

class _RetrieveFilesState extends State<RetrieveFiles> {
  final _firestore = Firestore.instance;
  bool isDate = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'الملفات',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.sort,
              color: Colors.black,
              size: 50,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) =>  AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        content: Builder(
                          builder: (BuildContext context) {
// Get available height and width of the build area of this widget. Make a choice depending on the size.
                            var height = MediaQuery.of(context).size.height;
                            var width = MediaQuery.of(context).size.width;

                            return Container(
                              height: height - 600,
                              width: width - 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'ترتيب بواسطة',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF888888),
                                    ),
                                  ),
                                  Center(
                                    child: Card(
                                      elevation: 10,
                                      child: GestureDetector(
                                        child: Padding(
                                          padding:  EdgeInsets.all(15.0),
                                          child: Text(
                                            'التاريخ (من الأحدث للأقدم)',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            isDate = false;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Card(
                                      elevation: 10,
                                      child: GestureDetector(
                                        child: Padding(
                                          padding:  EdgeInsets.all(15.0),
                                          child: Text(
                                            'التاريخ (من الأقدم للأحدث)',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            isDate = true;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: FlatButton(
                                      onPressed: () {
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
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ));
            }),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('file')
            .orderBy('arabicDate', descending: isDate)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          //------------------------------------------------
          return (snapshot.data.documents.length == 0)
              ? HomePAge()
              : ListView.builder(
                  padding: EdgeInsets.all(15.0),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (_, int index) {
                    String fileName = snapshot.data.documents[index]["name"];
                    String fileDetails =
                        snapshot.data.documents[index]["details"];
                    String history = snapshot.data.documents[index]["history"];
                    String fileKind =
                        snapshot.data.documents[index]["fileKind"];
                    String imageUrl =
                        snapshot.data.documents[index]["imageUrl"];
                    String fileUrl = snapshot.data.documents[index]["fileUrl"];
                    String arabicDate =
                        snapshot.data.documents[index]["arabicDate"];

                    return ReusableFileData(
                      fileName: fileName,
                      fileDetails: fileDetails,
                      arabicDate: arabicDate,
                      view: () {
                        if ((fileKind == 'image') && (imageUrl != null)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageView(
                                      url: imageUrl,
                                    )),
                          );
                        } else if ((fileKind == 'pdf') && (fileUrl != null)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PdfView(
                                      url: fileUrl,
                                    )),
                          );
                        }
                      },
                      delete: () async {
                        await Firestore.instance.runTransaction(
                          (Transaction myTransaction) async {
                            await myTransaction.delete(
                                snapshot.data.documents[index].reference);
                          },
                        );
                      },
                      update: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateFile(
                                docID: widget.docID,
                                name: fileName,
                                details: fileDetails,
                                history: history),
                          ),
                        );
                      },
                    );
                  },
                );
        },
      ),
      //----------------------------------------------------------
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFiles(),
            ),
          );
        },
        child: Text(
          '+',
          style: TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }
}
