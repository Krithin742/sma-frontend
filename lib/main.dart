import 'package:flutter/material.dart';
import 'package:student/homepage.dart';
import 'package:student/timetable.dart';
import 'package:student/timetable_create.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      home:TimetableScreen(),
    );
  }
}






