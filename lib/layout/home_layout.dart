import 'package:app/modules/archived_secreen/archived_secreen.dart';
import 'package:app/modules/done_secreen/done_secreen.dart';
import 'package:app/modules/tasks_secreen/task_secreen.dart';
import 'package:app/shared/components/components.dart';
import 'package:app/shared/components/constants.dart';
import 'package:app/shared/cubit/cubit.dart';
import 'package:app/shared/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var taskController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDb(),
      child: BlocConsumer<AppCubit, AppStastes>(
        listener: (context, state) {
          if (state is AppInserteDB) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.appbar[cubit.indexGen],),
              
            ),
            floatingActionButton: FloatingActionButton(
              child: cubit.iconFloatingActionButton,
              onPressed: () {
                if (cubit.openBottomSheet) {
                  if (formKey.currentState.validate()) {
                    cubit.insertDb(
                        titel: taskController.text,
                        date: dateController.text,
                        time: timeController.text);
                  }
                } else {
                  cubit.iconFloatingActionButton = Icon(Icons.add);

                  scaffoldKey.currentState
                      .showBottomSheet((context) {
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
                                        timeController.text =
                                            value.format(context);
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
                      }, elevation: 40)
                      .closed
                      .then((value) {
                        cubit.changeBottomSheetStates(
                          isShow: false,
                          icon: Icon(Icons.edit),
                        );
                      });
                  cubit.changeBottomSheetStates(
                    isShow: true,
                    icon: Icon(Icons.add),
                  );
                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.indexGen,
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  cubit.currentIndex(value);
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
            body: ConditionalBuilder(
              condition: state is! AppgeteDBLoading,
              builder: (context) => cubit.secreens[cubit.indexGen],
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
