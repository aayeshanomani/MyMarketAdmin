import 'package:flutter/material.dart';

class ApplicantScreen extends StatefulWidget {
  final String username;

  const ApplicantScreen({Key? key, required this.username}) : super(key: key);
 
  @override
  _ApplicantScreenState createState() => _ApplicantScreenState();
}

class _ApplicantScreenState extends State<ApplicantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Color(0xffA7C957),
      ),
      body: Center(child: Container(child: Text("Hello "+widget.username+", your application is under consideration."),))
    );
  }
}
