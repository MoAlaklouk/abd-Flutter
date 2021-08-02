import 'package:app/bmi_secreen.dart';
import 'package:app/home_screen.dart';
import 'package:app/login_screnn.dart';
import 'package:app/messenger_screen.dart';
import 'package:app/result_BMI.dart';
import 'package:app/user_model.dart';
import 'package:flutter/material.dart';
import 'home_man.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  
      home: BmiCal(),
    );
  }
}
