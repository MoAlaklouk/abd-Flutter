import 'package:flutter/material.dart';

class Messenger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              icon: CircleAvatar(
//                radius: 50,
                backgroundColor: Colors.black,
                child: Icon(Icons.camera_alt),
              ),
              onPressed: () {}),
          IconButton(
              icon: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(Icons.edit),
              ),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadiusDirectional.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(
                        width: 15,
                      ),
                      Text('Search'),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 100,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => BuildStory(),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 20,
                        ),
                    itemCount: 10),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => BuildChat(),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 20,
                        ),
                    itemCount: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildStory() {
    return Container(
      width: 60.0,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, right: 5),
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Mo Alaklouk Mohammad Alaklouk',
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget BuildChat() {
    return Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8, right: 5),
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mo Alaklouk Mohammad Alaklouk Mo Alaklouk Mohammad AlakloukMo Alaklouk Mohammad Alaklouk',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'hello my name is Ahamed AhamedAhamedAhamed',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: CircleAvatar(
                      radius: 3,
                      backgroundColor: Colors.black,
                    ),
                  ),
                  Expanded(child: Text('02:40 am'))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
