import 'package:app/layout/news_app/cubit/state.dart';
import 'package:app/layout/news_app/cubit/cubit.dart';
import 'package:app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class searchSecreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var search = TextEditingController();
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: textfield(
                    controller: search,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Search must be not empty';
                      }
                      return null;
                    },
                    onChange: (value) {
                      NewsCubit.get(context).getsearch(value);
                    },
                    inputType: TextInputType.text,
                    text: 'search',
                    prefix: Icons.search),
              ),
              Expanded(
                child: articlaeBuilder(list,isSearch: true),
              ),
            ],
          ),
        );
      },
    );
  }
}
