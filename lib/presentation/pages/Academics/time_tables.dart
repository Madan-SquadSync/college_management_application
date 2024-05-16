import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/presentation/bloc/time_tables_bloc/time_tables_bloc.dart';
import 'package:nricse123/presentation/bloc/time_tables_bloc/time_tables_event.dart';
import 'package:nricse123/presentation/bloc/time_tables_bloc/time_tables_state.dart';

class TimeTables extends StatelessWidget {
  const TimeTables({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text("Time tables" , style: Theme.of(context).textTheme.titleLarge, ),
      ),
    );
  }
}
