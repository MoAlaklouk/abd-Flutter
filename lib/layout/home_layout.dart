import 'package:app/modules/archived_secreen/archived_secreen.dart';
import 'package:app/modules/done_secreen/done_secreen.dart';
import 'package:app/modules/tasks_secreen/task_secreen.dart';
import 'package:app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomeLayout> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  Database dataBase;
  List<Widget> secreens = [TaskSecreen(), DoneSecreen(), ArchivedSecreen()];
  List appbar = ['New Task', 'Done Task', 'Archived Task'];
  int index = 0;
  @override
  void initState() {
    super.initState();
    createDb();
  }

  bool openBottomSheet = false;
  Icon iconFloatingActionButton = Icon(Icons.edit);
  var taskController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(appbar[index]),
      ),
      floatingActionButton: FloatingActionButton(
          child: iconFloatingActionButton,
          onPressed: () {
            if (openBottomSheet) {
              if (formKey.currentState.validate()) {
                setState(() {
                  iconFloatingActionButton = Icon(Icons.edit);
                });
                insertDb(
                        titel: taskController.text,
                        date: dateController.text,
                        time: timeController.text)
                    .then((value) {
                  Navigator.pop(context);
                  openBottomSheet = false;
                }).catchError((erorr) {
                  print('erorr when insert in button $erorr');
                });
              }
            } else {
              setState(() {
                iconFloatingActionButton = Icon(Icons.add);
              });
             
              scaffoldKey.currentState.showBottomSheet((context) {
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textfield(
                          controller: taskController,
                          inputType: TextInputType.text,
                          prefix: Icons.text_format,
                          text: 'Task Name',
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'you must full this part';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        textfield(
                            controller: timeController,
                            inputType: TextInputType.datetime,
                            prefix: Icons.watch_later_outlined,
                            text: 'Time Task',
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'you must full this part';
                              }
                            },
                            OnTapFunc: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                timeController.text = value.format(context);
                              });
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        textfield(
                          controller: dateController,
                          inputType: TextInputType.datetime,
                          prefix: Icons.calendar_today,
                          text: 'Date Task',
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'you must full this part';
                            }
                          },
                          OnTapFunc: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2022))
                                .then((value) {
                              dateController.text =
                                  DateFormat.yMMMd().format(value);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }, elevation: 40);
              openBottomSheet = true;
            }
          }),
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

  void createDb() async {
    dataBase = await openDatabase(
      'dataBase',
      version: 1,
      onCreate: (db, version) async {
        print('db created');
        db
            .execute(
                'CREATE TABLE  tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT) ')
            .then((value) {
          print('create table');
        }).catchError((erorr) {
          print('erorr in Create table ${erorr.toString()}');
        });
      },
      onOpen: (db) {
        print('open db');
      },
    );
  }

  Future insertDb({
    @required String titel,
    @required String date,
    @required String time,
  }) async {
    return await dataBase.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$titel","$date","$time","new")')
          .then((value) {
        print('$value insert successfully');
      }).catchError((erorr) {
        print('erorr when insert ${erorr.toString()}');
      });
      return null;
    });
  }
}
