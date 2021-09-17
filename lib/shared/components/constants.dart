// POST
// UPDATE
// DELETE

// GET

// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=545215c0085a4510ba607f072682e79c

// https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=545215c0085a4510ba607f072682e79c
// https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=  545215c0085a4510ba607f072682e79c
//  https://newsapi.org/v2/top-headlines?q=trump&apiKey=545215c0085a4510ba607f072682e79c

//search
//https://newsapi.org/v2/everything?q=tesla&from=2021-07-26&sortBy=publishedAt&apiKey=545215c0085a4510ba607f072682e79c
import 'package:app/modules/shopApp_secreens/shop_login/shopLogin_secreen.dart';
import 'package:app/shared/network/local/cache_helper.dart';
import 'package:app/shared/components/components.dart';

void siginOtu(context) {
  CacheHelper.removedData(key: 'token').then((value) {
    if (value) {
      naviagtTofinish(context, ShopLoginSecreen());
    }
  });
}

String token = '';
