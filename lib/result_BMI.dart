import 'package:flutter/material.dart';

class ResultBmi extends StatelessWidget {
  bool ismale;
  double result;
  double age;
  ResultBmi({
    @required this.age,
    @required this.ismale,
    @required this.result,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         centerTitle: true,
        title: Text('BMI Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender = ${ismale ? 'Male' : 'Female'}',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            Text(
              'Result = ${result.round()}',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            Text(
              'Age = ${age.round()}',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
