import 'package:app/layout/news_app/cubit/cubit.dart';
import 'package:app/layout/news_app/cubit/state.dart';
import 'package:app/shared/cubit/cubit.dart';
import 'package:app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSecreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusnisess(),
      child: BlocConsumer<NewsCubit, NewsState>(
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            body: cubit.secreens[cubit.currentIndex],
            appBar: AppBar(
              title: Text(
                'News App',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.brightness_2_outlined),
                    onPressed: () {
                      AppCubit.get(context).themChange();
                    })
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: cubit.bottomItem,
              currentIndex: cubit.currentIndex,
              onTap: (value) {
                cubit.changeBottomNavBar(value);
              },
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
