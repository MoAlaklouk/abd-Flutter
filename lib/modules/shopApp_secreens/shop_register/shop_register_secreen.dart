import 'package:app/layout/shop_app/shop_layout.dart';
import 'package:app/modules/shopApp_secreens/shop_login/shopLogin_secreen.dart';
import 'package:app/modules/shopApp_secreens/shop_register/cubit/cubit.dart';
import 'package:app/modules/shopApp_secreens/shop_register/cubit/states.dart';
import 'package:app/shared/components/constants.dart';
import 'package:app/shared/network/local/cache_helper.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var loginController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);

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
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
            titleSpacing: -15,
              
              title: TextButton(
                child: Text(
                  'SGIN IN',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800]),
                ),
                onPressed: () {
                  naviagtTofinish(context, ShopLoginSecreen());
                },
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Creat New Account',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        // Text(
                        //   'Register now to browse our hot offers',
                        //   style: Theme.of(context).textTheme.bodyText1.copyWith(
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        SizedBox(
                          height: 40.0,
                        ),
                        textfield(
                          radius: 50,
                          controller: nameController,
                          inputType: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                          text: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        textfield(
                          radius: 50,
                          controller: emailController,
                          inputType: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          text: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        textfield(
                          radius: 50,
                          controller: passwordController,
                          inputType: TextInputType.visiblePassword,
                          suffixIcon: ShopRegisterCubit.get(context).suffix,
                          onSubmit: (value) {},
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffixPress: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          text: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        textfield(
                          radius: 50,
                          controller: phoneController,
                          inputType: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your phone number';
                            }
                          },
                          text: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            radius: 50,
                            function: () {
                              if (formKey.currentState.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'SIGN Up',
                          
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
