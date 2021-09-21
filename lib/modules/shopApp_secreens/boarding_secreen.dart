import 'package:app/modules/shopApp_secreens/shop_login/shopLogin_secreen.dart';
import 'package:app/shared/components/components.dart';
import 'package:app/shared/network/local/cache_helper.dart';
import 'package:app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardarModel {
  final String image;
  final String titel;
  final String body;
  BoardarModel({
    @required this.image,
    @required this.body,
    @required this.titel,
  });
}

class BoardingSecreen extends StatefulWidget {
  @override
  _BoardingSecreenState createState() => _BoardingSecreenState();
}

class _BoardingSecreenState extends State<BoardingSecreen> {
  var bordController = PageController();

  bool last = false;

  List<BoardarModel> boarder = [
    BoardarModel(
      image: 'assets/images/boardar1.png',
      body: 'Many of products',
      titel: 'Shop App',
    ),
    BoardarModel(
      image: 'assets/images/boardar2.png',
      body: 'Favorite Items',
      titel: 'Easy',
    ),
    BoardarModel(
      image: 'assets/images/boardar3.png',
      body: 'Buy some products',
      titel: 'Buy',
    ),
  ];
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) naviagtTofinish(context, ShopLoginSecreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text(
                'SKIP',
                style: TextStyle(
                  fontSize: 18,
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: bordController,
                onPageChanged: (value) {
                  if (value == boarder.length - 1) {
                    setState(() {
                      last = true;
                    });
                  } else {
                    setState(() {
                      last = false;
                    });
                  }
                },
                itemBuilder: (context, index) {
                  return BoardarWidget(boarder[index]);
                },
                itemCount: boarder.length,
                physics: BouncingScrollPhysics(),
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: bordController,
                  count: boarder.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: DefaultColer(),
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  
                  
                  onPressed: () {
                    if (last) {
                      submit();
                    } else {
                      bordController.nextPage(
                        duration: Duration(
                          milliseconds: 800,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward,color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BoardarWidget(BoardarModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '${model.titel}',
            style: TextStyle(
              fontFamily: 'Merienda',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              // fontFamily:'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      );
}
