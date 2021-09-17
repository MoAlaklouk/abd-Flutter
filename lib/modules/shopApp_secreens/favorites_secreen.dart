import 'package:app/layout/shop_app/cubit/cubit.dart';
import 'package:app/layout/shop_app/cubit/states.dart';
import 'package:app/models/shop_model/favorites_model.dart';
import 'package:app/models/shop_model/favorite_change_model.dart';
import 'package:app/shared/components/components.dart';
import 'package:app/shared/styles/colors.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => favoItems(ShopCubit.get(context).favoritesModel.data.data[index], context),
            separatorBuilder: (context, index) => separatorB(),
            itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  }

  Widget favoItems(FavoritesData model, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.product.image),
                    width: 120,
                    height: 120,
                  ),
                  if (model.product.discount != 0)
                    Container(
                      padding: EdgeInsetsDirectional.all(2),
                      color: Colors.red,
                      child: Text(
                        'Discount',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                ],
              ),
             SizedBox( width: 20,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product.name,
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          model.product.price.toString(),
                          style: TextStyle(
                              color: DefaultColer(),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (1 != 0)
                          Text(
                            model.product.oldPrice.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            print('model.id');
                            ShopCubit.get(context)
                                .changeFavorites(model.product.id);
                          },
                          icon:
                              ShopCubit.get(context).favorites[model.product.id]
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                    ),
                        ),
                        // padding:EdgeInsets.zero ,
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
  );

