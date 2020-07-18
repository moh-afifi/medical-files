import 'package:flutter/material.dart';

class AddAppointment extends StatefulWidget {
  @override
  _AddAppointmentState createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حجز عند طبيب'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('صفحة الحجز عند طبيب'),
      ),
    );
  }
}
