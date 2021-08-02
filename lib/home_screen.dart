import 'package:flutter/material.dart';

class HomeSecreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              print('menu');
            }),
        title: Text('App'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('search');
              }),
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                print('notifications');
              })
        ],
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(
                    20.0,
                  ),
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                    height: 200,
                    width: 300,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__340.jpg'),
                  ),
                  Container(
                      height: 50,
                      color: Colors.black.withOpacity(.7),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Text(
                        'Hello',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
