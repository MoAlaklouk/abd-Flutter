import 'package:app/layout/news_app/cubit/cubit.dart';
import 'package:app/layout/news_app/cubit/state.dart';
import 'package:app/shared/components/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusnisessSecreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      builder: (context, state) {
        var list = NewsCubit.get(context).busnisess;
        return articlaeBuilder(list);
      },
      listener: (context, state) {},
    );
  }
}
