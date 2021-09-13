import 'package:app/layout/shop_app/shop_layout.dart';
import 'package:app/layout/todo_app/home_layout.dart';
import 'package:app/modules/shopApp_secreens/shop_login/cubit/cubit.dart';
import 'package:app/modules/shopApp_secreens/shop_login/cubit/state.dart';
import 'package:app/modules/shopApp_secreens/shop_register_secreen.dart';
import 'package:app/shared/components/components.dart';
import 'package:app/shared/network/local/cache_helper.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopLoginSecreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'login',
                          style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'Merienda',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        textfield(
                            controller: emailController,
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
                          height: 15,
                        ),
                        textfield(
                            isPassword: ShopLoginCubit.get(context).isVisble,
                            suffixIcon: ShopLoginCubit.get(context).suffix,
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
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passController.text,
                                );
                              }
                            },
                            text: 'LOGIN',
                          ),
                        ),
                        SizedBox(
                          height: 15,
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
                                naviagtTo(context, ShopRegisterSecreen());
                              },
                              child: Text('REGISTER'),
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
            if (state is ShopSucssesState) {
              if (state.loginModel.status) {
                print(state.loginModel.message);
                print(state.loginModel.data.token);
                naviagtTo(context, ShopLayout());
                CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data.token,
                );
           
                toast(
                  state: ToastStates.SUCCESS,
                  masg: state.loginModel.message,
                );
              } else {
                print(state.loginModel.message);
                toast(
                  state: ToastStates.ERORR,
                  masg: state.loginModel.message,
                );
              }
            }
          },
        ));
  }
}
