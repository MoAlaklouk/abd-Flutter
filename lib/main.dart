import 'package:app/shared/bloc_opserver.dart';
import 'package:app/shared/cubit/cubit.dart';
import 'package:app/shared/cubit/states.dart';
import 'package:app/shared/network/local/cache_helper.dart';
import 'package:app/shared/network/remote/dio_helper.dart';
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
  bool isdark = CacheHelper.getBool(key: 'isdark');
  runApp(MyApp(isdark));
}

class MyApp extends StatelessWidget {
  final bool isdark;

  MyApp(this.isdark);

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
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                titleSpacing: 20,
                elevation: 0),
            scaffoldBackgroundColor: Colors.white,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.black),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.deepOrange,
            appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                backgroundColor: HexColor('333739'),
                titleSpacing: 20,
                elevation: 0),
            scaffoldBackgroundColor: HexColor('333739'),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                backgroundColor: HexColor('333739'),
                unselectedItemColor: Colors.white),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          themeMode:
              AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: NewsSecreen(),
        ),
      ),
    );
  }
}
