import 'package:flutter/material.dart';

class UserModel {
  final int id;
  final String name;
  final String phone;
  UserModel({
    @required this.id,
    @required this.name,
    @required this.phone,
  });
}

class UserScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(id: 1, name: 'mo', phone: '11111111'),
    UserModel(id: 2, name: 'ahmed', phone: '2222222'),
    UserModel(id: 3, name: 'mohsen', phone: '3333333'),
  UserModel(id: 4, name: 'seed', phone: '44444444'),
    UserModel(id: 5, name: 'ans', phone: '555555'),
    UserModel(id: 6, name: 'khaled', phone: '12342345678'),
    UserModel(id: 7, name: 'dad', phone: '12345672348'),
    UserModel(id: 8, name: 'mom', phone: '12345234678'),
    UserModel(id: 9, name: 'khaled', phone: '12342345678'),
    UserModel(id: 10, name: 'dad', phone: '12345672348'),
    UserModel(id: 11, name: 'mom', phone: '12345234678'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Users'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => BuildUser(users[index]),
        separatorBuilder: (context, index) => Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey[300],
        ),
        itemCount: users.length,
      ),
    );
  }

  Widget BuildUser(UserModel user) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.green,
            child: Text(
              '${user.id}',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${user.name}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${user.phone}',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
