import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  ImageView({this.url});
  final String url;

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool isLoading;
  void showProgress(){
    setState(() {
      isLoading=true;
    });
    new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        isLoading=false;
      });
    });
  }

  @override
  void initState() {
    showProgress();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff021432),
        title: Text('View Image',style: TextStyle(color: Colors.white, fontSize: 20),),
        centerTitle: true,
      ),
      body: Center(
        child: isLoading? Center(child: CircularProgressIndicator()) : Image.network(widget.url,width: 300,height: 600,),
      ),
    );
  }
}
