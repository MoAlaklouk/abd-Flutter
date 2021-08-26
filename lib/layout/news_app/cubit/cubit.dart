import 'package:app/layout/news_app/cubit/state.dart';
import 'package:app/modules/newsapp_secreens/business_secreen/business_secreen.dart';
import 'package:app/modules/newsapp_secreens/science_secreen/science_secreen.dart';
import 'package:app/modules/newsapp_secreens/settings_secreen/settings_secreen.dart';
import 'package:app/modules/newsapp_secreens/sports_secreen/sports_secreen.dart';
import 'package:app/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  List<Widget> secreens = [
    BusnisessSecreen(),
    ScienceSecreen(),
    SportseSecreen(),
  ];
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business_center,
        ),
        label: 'Busnisess'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Science'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports_baseball,
        ),
        label: 'Sports'),
  ];
  void changeBottomNavBar(int index) {
    if (index == 2) {
      getSports();
    }
    if (index == 1) {
      getScience();
    }
    currentIndex = index;
    emit(NewsCangBotomNavBar());
  }

  List<dynamic> busnisess = [];

  void getBusnisess() {
    emit(NewsGetBusniessLoadingState());
    if (busnisess.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': '545215c0085a4510ba607f072682e79c',
        },
      ).then((value) {
        busnisess = value.data['articles'];

        emit(NewsGetBusniessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusniessErorrState(error.toString()));
      });
    } else {
      emit(NewsGetBusniessSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'Science',
          'apiKey': '545215c0085a4510ba607f072682e79c',
        },
      ).then((value) {
        //   print(value.data['articles'][0][]);
        science = value.data['articles'];

        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErorrState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'Sports',
          'apiKey': '545215c0085a4510ba607f072682e79c',
        },
      ).then((value) {
        //   print(value.data['articles'][0][]);
        sports = value.data['articles'];

        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErorrState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }
}
