import 'package:app/modules/todoApp_secreens/archived_secreen/archived_secreen.dart';
import 'package:app/modules/todoApp_secreens/done_secreen/done_secreen.dart';
import 'package:app/modules/todoApp_secreens/tasks_secreen/task_secreen.dart';
import 'package:app/shared/cubit/states.dart';
import 'package:app/shared/network/local/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStastes> {
  List<Map> newTaskDB = [];
  List<Map> doneTaskDB = [];
  List<Map> archivedTaskDB = [];

  bool openBottomSheet = false;
  Icon iconFloatingActionButton = Icon(Icons.edit);
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  List<Widget> secreens = [
    TaskSecreen(),
    DoneSecreen(),
    ArchivedSecreen(),
  ];
  List appbar = [
    'New Task',
    'Done Task',
    'Archived Task',
  ];
  int indexGen = 0;
  Database dataBase;
  void currentIndex(int index) {
    indexGen = index;
    emit(AppCangBotomNavBar());
  }

  void createDb() {
    openDatabase(
      'dataBase',
      version: 1,
      onCreate: (dataBase, version) async {
        print('db created');
        dataBase
            .execute(
                'CREATE TABLE  tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT) ')
            .then((value) {
          print('create table');
        }).catchError((erorr) {
          print('erorr in Create table ${erorr.toString()}');
        });
      },
      onOpen: (dataBase) {
        getFromDB(dataBase);
        print('open db');
      },
    ).then((value) {
      dataBase = value;

      emit(AppCreateDB());
    });
  }

  insertDb({
    @required String titel,
    @required String date,
    @required String time,
  }) async {
    await dataBase.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$titel","$date","$time","new")')
          .then((value) {
        print('$value insert successfully');

        emit(AppInserteDB());
        getFromDB(dataBase);
      }).catchError((erorr) {
        print('erorr when insert ${erorr.toString()}');
      });
      return null;
    });
  }

  void getFromDB(dataBase) {
    newTaskDB = [];
    doneTaskDB = [];
    archivedTaskDB = [];
    emit(AppgeteDBLoading());
    dataBase.rawQuery('SELECT * FROM tasks').then((value) {
      //print(value);

      value.forEach((element) {
        if (element['status'] == 'new') {
          newTaskDB.add(element);
        } else if (element['status'] == 'done') {
          doneTaskDB.add(element);
        } else {
          archivedTaskDB.add(element);
        }
      });
      emit(AppgeteDB());
    });
    ;
  }

  void updateFromDB({
    @required String status,
    @required int id,
  }) {
    dataBase.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [
      '$status',
      id,
    ]).then((value) {
      getFromDB(dataBase);
      emit(AppUpdateeDB());
    });
  }

  void deleteFromDB({
    @required int id,
  }) {
    dataBase.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getFromDB(dataBase);
      emit(AppDeleteDB());
    });
  }

  void changeBottomSheetStates({
    @required bool isShow,
    @required Icon icon,
  }) {
    openBottomSheet = isShow;
    iconFloatingActionButton = icon;
    emit(AppCangBotomSheetState());
  }

  bool isdark = true;
  void themChange({bool fromShered}) {
    if (fromShered != null) {
      isdark = fromShered;
      emit(AppCangThemeState());  
    } else {
      isdark = !isdark;
      CacheHelper.saveData(key: 'isdark', value: isdark).then((value) {
        emit(AppCangThemeState());
      });
    }
  }
}
