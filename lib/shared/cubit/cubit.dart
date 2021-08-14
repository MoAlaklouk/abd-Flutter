import 'package:app/modules/archived_secreen/archived_secreen.dart';
import 'package:app/modules/done_secreen/done_secreen.dart';
import 'package:app/modules/tasks_secreen/task_secreen.dart';
import 'package:app/shared/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStastes> {
  List<Map> getTaskDB = [];

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
        getFromDB(dataBase).then((value) {
          getTaskDB = value;
         
          emit(AppgeteDB());
        });
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
        getFromDB(dataBase).then((value) {
          getTaskDB = value;
          print(getTaskDB);
          emit(AppgeteDB());
        });
      }).catchError((erorr) {
        print('erorr when insert ${erorr.toString()}');
      });
      return null;
    });
  }

  Future<List<Map>> getFromDB(dataBase) async {
    emit(AppgeteDBLoading());
    return await dataBase.rawQuery('SELECT * FROM tasks');
  }

  void changeBottomSheetStates({
    @required bool isShow,
    @required Icon icon,
  }) {
    openBottomSheet = isShow;
    iconFloatingActionButton = icon;
    emit(AppCangBotomSheetState());
  }
}