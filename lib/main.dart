import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:student/Alarm.dart';
import 'package:student/LoginPage.dart';
import 'package:student/RegistrationPage.dart';
import 'package:student/activity.dart';
import 'package:student/homepage.dart';
import 'package:student/chatbot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
