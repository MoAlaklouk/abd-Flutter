import 'package:app/layout/shop_app/cubit/cubit.dart';
import 'package:app/layout/shop_app/shop_layout.dart';
import 'package:app/layout/todo_app/home_layout.dart';
import 'package:app/modules/shopApp_secreens/shop_login/cubit/cubit.dart';
import 'package:app/modules/shopApp_secreens/shop_login/cubit/state.dart';
import 'package:app/modules/shopApp_secreens/shop_register/shop_register_secreen.dart';
import 'package:app/shared/components/components.dart';
import 'package:app/shared/components/constants.dart';
import 'package:app/shared/cubit/cubit.dart';
import 'package:app/shared/network/local/cache_helper.dart';
import 'package:app/shared/styles/colors.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ShopLoginSecreen extends StatelessWidget {
  var loginController = PageController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: loginController,
                    count: 2,
                    effect: WormEffect(activeDotColor: Colors.grey,spacing: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SmoothPageIndicator(
                    controller: loginController,
                    count: 3,
                    
                    effect: ExpandingDotsEffect(activeDotColor: Colors.grey,spacing: 20),
                  ),
                ],
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/images/shopLogin.png'),
                          width: 200,
                          height: 200,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Welcome',
                          style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'Merienda',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   'Login now to browse our hot offers',
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.w500,
                        //     color: Colors.grey[600],
                        //   ),
                        // ),
                        SizedBox(
                          height: 50,
                        ),
                        textfield(
                            controller: emailController,
                            radius: 50,
                            onSubmit: (value) {
                              if (formKey.currentState.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passController.text,
                                );
                              }
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Email';
                              }
                              return null;
                            },
                            inputType: TextInputType.emailAddress,
                            text: 'Email',
                            prefix: Icons.email),
                        SizedBox(
                          height: 40,
                        ),
                        textfield(
                            isPassword: ShopLoginCubit.get(context).isVisble,
                            suffixIcon: ShopLoginCubit.get(context).suffix,
                            radius: 50,
                            suffixPress: () {
                              ShopLoginCubit.get(context).changePasswordVisb();
                            },
                            controller: passController,
                            onSubmit: (value) {
                              if (formKey.currentState.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passController.text,
                                );
                              }
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter password';
                              }
                              return null;
                            },
                            inputType: TextInputType.text,
                            text: 'Password',
                            prefix: Icons.lock),
                        SizedBox(
                          height: 50,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                          builder: (context) => defaultButton(
                            radius: 50,
                            function: () {
                              if (formKey.currentState.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passController.text,
                                );
                              }
                            },
                            text: 'SIGN IN',
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an accont?',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            TextButton(
                              onPressed: () {
                                naviagtTo(context, ShopRegisterScreen());
                              },
                              child: Text('SGIN UP'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          listener: (context, state) {
            if (state is ShopLoginSuccessState) {
              if (state.loginModel.status) {
                CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data.token,
                ).then((value) {
                  token = state.loginModel.data.token;

                  naviagtTofinish(
                    context,
                    ShopLayout(),
                  );
                });
              } else {
                print(state.loginModel.message);

                toast(
                  masg: state.loginModel.message,
                  state: ToastStates.ERORR,
                );
              }
            }
          },
        ));
  }
}
