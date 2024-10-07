import 'package:dissertation_project_app/core/main_utils/main_bloc/main_bloc.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/bloc/to_do_bloc.dart';
import 'package:dissertation_project_app/feature/services/work_manager/bloc/work_manager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainBloc()),
        //..
        BlocProvider(create: (context) => ToDoBloc()),
        BlocProvider(create: (context) => WorkManagerBloc()),

      ],
      child: child,
    );
  }
}
