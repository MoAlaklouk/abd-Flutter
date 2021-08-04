import 'package:app/shared/components/components.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var controllerEmail = TextEditingController();

  var controllerPass = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              print('menu');
            }),
        title: Text('Login Screen'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('search');
              }),
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                print('notifications');
              })
        ],
        backgroundColor: Colors.lightBlue,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  textfield(
                      text: 'Email Adress',
                      controller: controllerEmail,
                      prefix: Icons.email,
                      inputType: TextInputType.emailAddress,
                      validate: (String velue) {
                        if (velue.isEmpty) {
                          return 'must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  textfield(
                      text: 'Password',
                      controller: controllerPass,
                      prefix: Icons.lock,
                      inputType: TextInputType.visiblePassword,
                      isPassword: isVisible,
                      suffixIcon:
                          isVisible ? Icons.visibility : Icons.visibility_off,
                      suffixPress: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      validate: (String velue) {
                        if (velue.isEmpty) {
                          return 'must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15,
                  ),

                  defaultButton(
                      text: 'login',
                      // isUpper: false,
                      radius: 10,
                      function: () {
                        if (formKey.currentState.validate()) {
                          print(controllerEmail.text);
                          print(controllerPass.text);
                        }
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  // defaultButton(
                  //   function: () {},
                  //   text: 'regester',
                  //   isUpper: false,
                  //   radius: 10,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'n have an account?'),
                      TextButton(
                        onPressed: () {},
                        child: Text('Register Now'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
