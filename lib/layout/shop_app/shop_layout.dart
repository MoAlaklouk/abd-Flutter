import 'package:app/modules/shopApp_secreens/shop_login/shopLogin_secreen.dart';
import 'package:app/shared/components/components.dart';
import 'package:app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('shop'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              CacheHelper.removedData(key: 'token').then(
                  (value) => naviagtTofinish(context, ShopLoginSecreen()));
            },
            child: Text('SIGN OUT'),
          )
        ],
      ),
    );
  }
}
