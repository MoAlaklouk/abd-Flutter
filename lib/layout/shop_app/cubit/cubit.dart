import 'package:app/layout/shop_app/cubit/states.dart';
import 'package:app/models/shop_model/categories_model.dart';
import 'package:app/models/shop_model/favorites_model.dart';
import 'package:app/models/shop_model/favoritesdata_model.dart';
import 'package:app/models/shop_model/home_model.dart';
import 'package:app/models/shop_model/shopLogin_model.dart';
import 'package:app/modules/shopApp_secreens/categories_secreen.dart';
import 'package:app/modules/shopApp_secreens/favorites_secreen.dart';
import 'package:app/modules/shopApp_secreens/product_secreen.dart';
import 'package:app/modules/shopApp_secreens/settings_secreen.dart';
import 'package:app/shared/components/constants.dart';
import 'package:app/shared/network/remote/dio_helper.dart';
import 'package:app/shared/network/remote/end_point.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> shopSecreens = [
    ProductSsecreen(),
    CategoriesSsecreen(),
    FavoritesSsecreen(),
    SettingSecreen(),
  ];
  int currentIndex = 0;

  void changeButtom(int index) {
    currentIndex = index;
    emit(ChangedBottomNevState());
  }

  Map<int, bool> favorites = {};
  HomeModel homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach(
        (element) {
          favorites.addAll({element.id: element.inFavorites});
        },
      );
      print(homeModel.status);

      emit(ShopSuccessHomeDataState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(ShopErorrHomeDataState(erorr));
    });
  }

  CategoriesModel categoriesModel;
  void getcategoriesData() {
    DioHelper.getData(
      url: get_categories,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      print(categoriesModel.status);
      emit(ShopSuccessCategoriesState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(ShopErorrCategoriesState(erorr));
    });
  }

  FavoritesModel favoritesModel;
  void changedFavorite(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoriteState());
    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      if (!favoritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else
        getFavoritesData();

      print(value.data);
      emit(ShopSuccessChangeFavoriteState(favoritesModel));
    }).catchError((erorr) {
      favorites[productId] = !favorites[productId];

      emit(ShopErorrChangeFavoriteState(erorr.toString()));
    });
  }

  FavoritesModelSec favoritesModelSec;
  void getFavoritesData() {
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModelSec = FavoritesModelSec.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessGetFavDataState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(ShopErorrGetFavDataState(erorr));
    });
  }

  ShopLoginModel profileModel;
  void getProfileData() {
    emit(ShopGetProfileDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      profileModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessGetProfileDataState(profileModel));
    }).catchError((erorr) {
      print(erorr.toString());
      emit(ShopErorrGetProfileDataState(erorr));
    });
  }
}
