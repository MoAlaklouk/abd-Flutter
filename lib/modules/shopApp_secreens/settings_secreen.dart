import 'package:app/layout/shop_app/cubit/cubit.dart';
import 'package:app/layout/shop_app/cubit/states.dart';
import 'package:app/shared/components/components.dart';
import 'package:app/shared/components/constants.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessUpdateUserState) {
          toast(
              masg: ShopCubit.get(context).userModel.message,
              state: ToastStates.SUCCESS);
        }
        if (state is ShopErrorUpdateUserState) {
          toast(
              masg: ShopCubit.get(context).userModel.message,
              state: ToastStates.ERORR);
        }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: model != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) {
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        if (state is ShopLoadingUpdateUserState)
                          LinearProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                        textfield(
                          controller: nameController,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'You must fill in the field';
                            }
                          },
                          inputType: TextInputType.text,
                          text: 'Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        textfield(
                          controller: emailController,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'You must fill in the field';
                            }
                          },
                          inputType: TextInputType.emailAddress,
                          text: 'Email',
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        textfield(
                          controller: phoneController,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'You must fill in the field';
                            }
                          },
                          inputType: TextInputType.text,
                          text: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                          function: () {
                            if (formKey.currentState.validate()) {
                              ShopCubit.get(context).userUpdateData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'UPDATE',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                            function: () {
                              siginOtu(context);
                            },
                            text: 'LOGOUT'),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
