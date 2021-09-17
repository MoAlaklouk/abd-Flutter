import 'package:app/layout/shop_app/cubit/cubit.dart';
import 'package:app/layout/shop_app/cubit/states.dart';
import 'package:app/models/shop_model/categories_model.dart';
import 'package:app/shared/components/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.categoriesModel != null,
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => Scaffold(
              body: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: categoriesItemPage(
                            cubit.categoriesModel.data.data[index]),
                      ),
                  separatorBuilder: (context, index) => separatorB(),
                  itemCount: cubit.categoriesModel.data.data.length)),
        );
      },
    );
  }

  Widget categoriesItemPage(DataModel model) => Row(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(model.image),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            model.name,
            style: TextStyle(fontSize: 20),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Spacer(),
          Icon(
            Icons.chevron_right_rounded,
            size: 50,
          )
        ],
      );
}
