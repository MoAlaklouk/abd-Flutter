import 'package:app/layout/shop_app/cubit/cubit.dart';
import 'package:app/layout/shop_app/cubit/states.dart';
import 'package:app/models/shop_model/shopLogin_model.dart';
import 'package:app/modules/shopApp_secreens/shop_login/cubit/state.dart';
import 'package:app/shared/components/constants.dart';
import 'package:app/shared/network/remote/dio_helper.dart';
import 'package:app/shared/network/remote/end_point.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel loginModel;
  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErorrState(error.toString()));
    });
  }

  bool isVisble = true;
  IconData suffix = Icons.visibility;
  void changePasswordVisb() {
    isVisble = !isVisble;
    suffix = isVisble ? Icons.visibility : Icons.visibility_off;

    emit(ShopchangeVisbletyPassState());
  }
}
