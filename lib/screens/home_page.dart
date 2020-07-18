import 'package:flutter/material.dart';
import 'add_files.dart';
class HomePAge extends StatefulWidget {
  @override
  _HomePAgeState createState() => _HomePAgeState();
}

class _HomePAgeState extends State<HomePAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          '    هنا يمكنك اضافة ملفاتك الطبية \nعن طريق الضغط على "+" في الاسفل',
          style: TextStyle(fontSize: 16),
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
