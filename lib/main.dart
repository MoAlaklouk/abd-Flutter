import 'package:app/layout/shop_app/shop_layout.dart';
import 'package:app/modules/shopApp_secreens/boarding_secreen.dart';
import 'package:app/modules/shopApp_secreens/shop_login/shopLogin_secreen.dart';
import 'package:app/shared/bloc_opserver.dart';
import 'package:app/shared/cubit/cubit.dart';
import 'package:app/shared/cubit/states.dart';
import 'package:app/shared/network/local/cache_helper.dart';
import 'package:app/shared/network/remote/dio_helper.dart';
import 'package:app/shared/styles/themes.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/news_layout.dart';
import 'layout/todo_app/home_layout.dart';
import 'modules/home/home_man.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool isdark = CacheHelper.getData(key: 'isdark');
  Widget widget;
  bool onboarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token');

  print(onboarding);

  if (onboarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginSecreen();
    }
  } else {
    widget = BoardingSecreen();
  }

  runApp(MyApp(
    isdark: isdark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isdark;
  final Widget startWidget;

  MyApp({this.isdark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()..getBusnisess(),
        ),
        BlocProvider(
          create: (context) => AppCubit()..themChange(fromShered: isdark),
        )
      ],
      child: BlocConsumer<AppCubit, AppStastes>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          theme: LightTheme(),
          darkTheme: darkTheme(),
          themeMode:
              AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: startWidget,
        ),
      ),
    );
  }
}
