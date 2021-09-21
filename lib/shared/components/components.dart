import 'package:app/layout/shop_app/cubit/cubit.dart';
import 'package:app/modules/newsapp_secreens/web_view/web_view.dart';
import 'package:app/shared/cubit/cubit.dart';
import 'package:app/shared/styles/colors.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  @required Function function,
  @required String text,
  bool isUpper = true,
  double radius = 0.0,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(radius),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: () => function(),
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
Widget textfield({
  @required TextEditingController controller,
  @required Function validate,
  Function onChange,
  Function onSubmit,
  @required TextInputType inputType,
  @required String text,
  @required IconData prefix,
  IconData suffixIcon,
  Function suffixPress,
  bool isPassword = false,
  double radius = 0.0,
  Function OnTapFunc,
}) =>
    TextFormField(
      onTap: OnTapFunc,
      controller: controller,
      validator: validate,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: Icon(prefix),
        suffixIcon: suffixIcon != null
            ? IconButton(icon: Icon(suffixIcon), onPressed: suffixPress)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );

Widget builedTaskInfo(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteFromDB(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('${model['time']}',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              radius: 40,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' ${model['title']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' ${model['date']}',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  AppCubit.get(context)
                      .updateFromDB(status: 'done', id: model['id']);
                }),
            IconButton(
                icon: Icon(
                  Icons.archive,
                  color: Colors.red,
                ),
                onPressed: () {
                  AppCubit.get(context)
                      .updateFromDB(status: 'archived', id: model['id']);
                }),
          ],
        ),
      ),
    );

Widget tasksBuilder({
  @required List getTaskDB,
}) =>
    ConditionalBuilder(
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) =>
            builedTaskInfo(getTaskDB[index], context),
        separatorBuilder: (context, index) => separatorB(),
        itemCount: getTaskDB.length,
      ),
      condition: getTaskDB.length > 0,
      fallback: (context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle, size: 50, color: Colors.grey),
            Text(
              'There are no Tasks',
              style: TextStyle(fontSize: 40, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
Widget buildArticleItem(
  article,
  context,
) {
  if (article['urlToImage'] == null) {
    article['urlToImage'] = 'https://i.stack.imgur.com/y9DpT.jpg';
  }
  return InkWell(
    onTap: () {
      naviagtTo(context, WebViewSecreen(article['url']));
    },
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              image: NetworkImage(
                '${article['urlToImage']}',
              ),
              fit: BoxFit.fill,
            ),
          ),
          width: 150,
          height: 150,
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            width: 150,
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget separatorB() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
      child: Column(
        children: [
          Container(
            color: Colors.grey[300],
            width: double.infinity,
            height: 1,
          ),
        ],
      ),
    );

Widget articlaeBuilder(list, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: buildArticleItem(list[index], context),
              ),
          separatorBuilder: (context, index) => separatorB(),
          itemCount: list.length),
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

void naviagtTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );

void naviagtTofinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );
void toast({@required String masg, @required ToastStates state}) {
  Fluttertoast.showToast(
      msg: masg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERORR, WARNING }

Color chooseColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;

      break;
    case ToastStates.ERORR:
      color = Colors.red;

      break;
    case ToastStates.WARNING:
      color = Colors.yellow;

      break;
  }
  return color;
}

Widget favoItems(model, context, {bool isSearch = true}) => Padding(
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
                  image: NetworkImage(model.image),
                  width: 120,
                  height: 120,
                ),
                if (model.discount != 0 && isSearch)
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
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                        model.price.toString(),
                        style: TextStyle(
                            color: DefaultColer(), fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0 && isSearch)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),

                      Spacer(),
                      if (isSearch)
                        IconButton(
                          onPressed: () {
                            print('model.id');
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
      ),
    );
