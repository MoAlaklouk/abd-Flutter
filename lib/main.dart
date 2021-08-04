import 'package:app/modules/bmi_secreen/bmi_secreen.dart';
import 'package:app/modules/home/home_screen.dart';
import 'package:app/modules/login/login_screnn.dart';
import 'package:app/modules/massenger/messenger_screen.dart';
import 'package:app/modules/result-bmi/result_BMI.dart';
import 'package:app/modules/user/user_model.dart';
import 'package:flutter/material.dart';
import 'modules/home/home_man.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
