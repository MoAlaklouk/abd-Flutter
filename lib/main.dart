import 'package:app/modules/bmi_secreen/bmi_secreen.dart';
import 'package:app/modules/home/home_screen.dart';
import 'package:app/modules/login/login_screnn.dart';
import 'package:app/modules/massenger/messenger_screen.dart';
import 'package:app/modules/result-bmi/result_BMI.dart';
import 'package:app/modules/user/user_model.dart';
import 'package:app/shared/bloc_opserver.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'layout/home_layout.dart';
import 'modules/home/home_man.dart';

void main() {
    Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
