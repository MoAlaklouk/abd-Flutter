import 'dart:ui';

import 'package:app/shared/components/components.dart';
import 'package:app/shared/components/constants.dart';
import 'package:app/shared/cubit/cubit.dart';
import 'package:app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivedSecreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStastes>(
      listener: (context, state) {},
      builder: (context, state) {
        var getTaskDB = AppCubit.get(context).archivedTaskDB;
        return ListView.separated(
          itemBuilder: (context, index) => builedTaskInfo(getTaskDB[index],context),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
            child: Container(
              color: Colors.grey[300],
              width: double.infinity,
              height: 1,
            ),
          ),
          itemCount: getTaskDB.length,
        );
      },
    );
  }
}
