import 'package:app/modules/archived_secreen/archived_secreen.dart';
import 'package:app/modules/done_secreen/done_secreen.dart';
import 'package:app/modules/tasks_secreen/task_secreen.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomeLayout> {
  List<Widget> secreens = [TaskSecreen(), DoneSecreen(), ArchivedSecreen()];
  List appbar = ['New Task', 'Done Task', 'Archived Task'];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbar[index]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var name = await getName();
          print(name);
          ;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            setState(() {
              index = value;
              print(index);
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline),
              label: 'Done',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined),
              label: 'Archived',
            ),
          ]),
      body: secreens[index],
    );
  }

  Future<String> getName() async {
    return 'ahmed ali';
  }
}
