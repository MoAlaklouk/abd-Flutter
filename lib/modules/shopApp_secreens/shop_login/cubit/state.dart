import 'package:app/models/shop_model/shopLogin_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopchangeVisbletyPassState extends ShopLoginStates {}

class ShopLoginErorrState extends ShopLoginStates {
  final String erorr;

  ShopLoginErorrState(this.erorr);
}
