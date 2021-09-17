
import 'package:app/layout/shop_app/cubit/cubit.dart';
import 'package:app/layout/shop_app/cubit/states.dart';
import 'package:app/models/shop_model/categories_model.dart';
import 'package:app/models/shop_model/favorites_model.dart';
import 'package:app/models/shop_model/home_model.dart';
import 'package:app/shared/components/components.dart';
import 'package:app/shared/styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.model.status) {
            toast(
              masg: state.model.message,
              state: ToastStates.ERORR,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: (ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null),
          builder: (context) {
            return productMBuldier(ShopCubit.get(context).homeModel,
                ShopCubit.get(context).categoriesModel, context);
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productMBuldier(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CarouselSlider(
            items: model.data.banners
                .map((e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              viewportFraction: 1.0,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.all(10),
            height: 126,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    buildCateqoriesProducts(categoriesModel.data.data[index]),
                separatorBuilder: (context, index) => SizedBox(
                      width: 18,
                    ),
                itemCount: categoriesModel.data.data.length),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'New Products',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsetsDirectional.all(2),
            color: Colors.grey[200],
            child: GridView.count(
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1 / 1.57,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                model.data.products.length,
                (index) =>
                    buildGridProducts(model.data.products[index], context),
              ),
            ),
          ),
        ]),
      );
  Widget buildGridProducts(ProductModel model, context) {
    
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  model.image,
                ),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 29,
                  child: Text(
                    model.name,
                    style: TextStyle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style: TextStyle(
                          color: DefaultColer(), fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        model.oldPrice.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        print(model.id);
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      icon: ShopCubit.get(context).favorites[model.id]
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
    );
  }

  Widget buildCateqoriesProducts(DataModel model) => Container(
        width: 80,
        height: 126,
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(model.image),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              model.name,
              style: TextStyle(fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
}
