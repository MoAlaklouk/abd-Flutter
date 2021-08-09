import 'package:flutter/material.dart';

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
 @required  TextInputType inputType,
 @required  String text,
 @required  IconData prefix,
  IconData suffixIcon,
  Function suffixPress,
  bool isPassword =false,
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
        border: OutlineInputBorder(),
        labelText: text,
        prefixIcon: Icon(prefix),
        suffixIcon:suffixIcon!=null?IconButton(icon: Icon(suffixIcon), onPressed: suffixPress ):null ,  
      ),
    );
