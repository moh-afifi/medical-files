import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class PdfView extends StatefulWidget {
  PdfView({this.url});
  final String url;
  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  bool _isLoading = true;
  PDFDocument document;

  viewPDF() async {
    setState(() => _isLoading = true);
      document = await PDFDocument.fromURL(widget.url);
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
viewPDF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff021432),
          title: Text('View PDF File',style: TextStyle(color: Colors.white, fontSize: 20),),
          centerTitle: true,
        ),
        body: Center(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : PDFViewer(document: document)),
      );
  }
}