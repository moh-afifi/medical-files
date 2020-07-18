//import 'package:files/reusables/reusable_file_data.dart';
//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:files/reusables/reusable_file_card.dart';
//class RetrieveFiles extends StatefulWidget {
//  @override
//  _RetrieveFilesState createState() => _RetrieveFilesState();
//}
//
//class _RetrieveFilesState extends State<RetrieveFiles> {
//  final _firestore = Firestore.instance;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Color(0xff021432),
//        title: Text(
//          'Files',
//          style: TextStyle(color: Colors.white, fontSize: 20),
//        ),
//        centerTitle: true,
//      ),
//      body: StreamBuilder<QuerySnapshot>(
//          stream: _firestore.collection('file').snapshots(),
//          builder: (context, snapshot) {
//            if (!snapshot.hasData) {
//              return Center(
//                child: CircularProgressIndicator(
//                  backgroundColor: Colors.blueAccent,
//                ),
//              );
//            }
//            final messages = snapshot.data.documents;
//            List<ReusableFileData> messageBubbles = [];
//            for (var message in messages) {
//
//              final fileName = message.data['name'];
//              final fileDetails = message.data['details'];
//
//              final messageBubble = ReusableFileData(
//                fileName: fileName,fileDetails: fileDetails,
//              );
//
//              messageBubbles.add(messageBubble);
//
//            }
//            return ListView(
//              padding:
//              EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//              children: messageBubbles,
//            );
//          }),
//    );
//  }
//}
