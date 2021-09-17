import 'package:app/models/shop_model/favorites_model.dart';
import 'package:app/models/shop_model/shopLogin_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ChangedBottomNevState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErorrHomeDataState extends ShopStates {
  final error;

  ShopErorrHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErorrCategoriesState extends ShopStates {
  final error;

  ShopErorrCategoriesState(this.error);
}

class ShopChangeFavoriteState extends ShopStates {}

class ShopSuccessChangeFavoriteState extends ShopStates {
  final FavoritesModel model;

  ShopSuccessChangeFavoriteState(this.model);
}

class ShopErorrChangeFavoriteState extends ShopStates {
  final error;

  ShopErorrChangeFavoriteState(this.error);
}

class ShopSuccessGetFavDataState extends ShopStates {}

class ShopErorrGetFavDataState extends ShopStates {
  final error;

  ShopErorrGetFavDataState(this.error);
}
class ShopGetProfileDataState extends ShopStates {}

class ShopSuccessGetProfileDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessGetProfileDataState(this.loginModel);
}

class ShopErorrGetProfileDataState extends ShopStates {
  final error;

  ShopErorrGetProfileDataState(this.error);
}