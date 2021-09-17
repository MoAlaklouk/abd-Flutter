import 'package:app/layout/shop_app/cubit/cubit.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/news_app/cubit/cubit.dart';

import 'shared/components/constants.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginSecreen();
  } else {
    widget = BoardingSecreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  // constructor
  // build
  final bool isDark;
  final Widget startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (context) => NewsCubit()
    //         ..getBusnisess()
    //         ..getSports()
    //         ..getScience(),
    //     ),
    //     BlocProvider(
    //       create: (BuildContext context) => AppCubit()
    //         ..themChange(
    //           fromShered: isDark,
    //         ),
    //     ),
    //     BlocProvider(
    //       create: (BuildContext context) => ShopCubit()
    //         ..getHomeData()
    //         ..getCategories()
    //         ..getFavorites()
    //         ..getUserData(),
    //     ),
    //   ],
    //   child: BlocConsumer<AppCubit, AppStastes>(
    //     listener: (context, state) {},
    //     builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: LightTheme(),
           // darkTheme: darkTheme(),
            //themeMode:
        
               // AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
  //       },
  //     ),
  //   );
  }
}
