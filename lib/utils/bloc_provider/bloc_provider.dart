import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dissertation_project_app/bloc/counter_bloc.dart';
// import 'package:dissertation_project_app/cubit/counter_cubit.dart';
// import 'package:dissertation_project_app/sign_in_app/bloc/auth_bloc.dart';
// import 'package:dissertation_project_app/to_do_list_app/cubit/todo_cubit.dart';
import 'package:dissertation_project_app/weather_app/bloc/weather_bloc.dart';
import 'package:dissertation_project_app/weather_app/data/repository/weather_repository.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => CounterCubit()),
        // BlocProvider(create: (context) => CounterBloc()),
        // BlocProvider(create: (context) => TodoCubit()),
        // BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(
          create: (context) => WeatherBloc(context.read<WeatherRepository>()),
        ),
      ],
      child: child,
    );
  }
}
