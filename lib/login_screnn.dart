import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  var controllerEmail = TextEditingController();
  var controllerPass = TextEditingController();
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
      body: Padding(
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
                TextField(
                  controller: controllerEmail,
                  //onChanged: ,
                  onSubmitted: (v) {
                    print(v);
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',
                      prefixIcon: Icon(Icons.email)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controllerPass,
                  onSubmitted: (v) {
                    print(v);
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                     color: Colors.blue,
                    ),
                  
                  width: double.infinity,
                 
                  child: MaterialButton(
                    onPressed: () {
                      print(controllerEmail.text);
                        print(controllerPass.text);

                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'n have an account?'),
                    TextButton(
                      onPressed: () {
                        
                      },
                      child: Text('Register Now'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
