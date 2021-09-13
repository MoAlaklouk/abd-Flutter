import 'package:app/models/shop_model/shop_model.dart';

abstract class ShopLoginStates {}

class ShopInitialState extends ShopLoginStates {}

class ShopSucssesState extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopSucssesState(this.loginModel);
}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopchangeVisbletyPassState extends ShopLoginStates {}

class ShopErorrState extends ShopLoginStates {
  final String erorr;

  ShopErorrState(this.erorr);
}
