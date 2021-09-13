import 'package:app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData LightTheme() => ThemeData(
      primarySwatch: DefaultColer(),
      appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          titleSpacing: 20,
          elevation: 0),
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor:DefaultColer(),
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
ThemeData darkTheme() => ThemeData(
      primarySwatch: DefaultColer(),
      appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('333739'),
            statusBarIconBrightness: Brightness.light,
          ),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: HexColor('333739'),
          titleSpacing: 20,
          elevation: 0),
      scaffoldBackgroundColor: HexColor('333739'),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: DefaultColer(),
          backgroundColor: HexColor('333739'),
          unselectedItemColor: Colors.white),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
