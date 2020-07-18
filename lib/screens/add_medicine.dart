import 'package:flutter/material.dart';

class AddMedicine extends StatefulWidget {
  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة دواء'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('صفحة اضافة دواء'),
      ),
    );
  }
}
