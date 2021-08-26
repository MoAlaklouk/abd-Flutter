import 'dart:ui';

import 'package:app/shared/components/components.dart';
import 'package:app/shared/components/constants.dart';
import 'package:app/shared/cubit/cubit.dart';
import 'package:app/shared/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskSecreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStastes>(
      listener: (context, state) {},
      builder: (context, state) {
        var getTaskDB = AppCubit.get(context).newTaskDB;
        return tasksBuilder(getTaskDB: getTaskDB);
      },
    );
  }
}