import 'package:app/models/shop_model/shopLogin_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopchangeVisbletyPassState extends ShopLoginStates {}

class ShopErorrState extends ShopLoginStates {
  final String erorr;

  ShopErorrState(this.erorr);
}
