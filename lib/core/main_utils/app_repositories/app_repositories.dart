import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dissertation_project_app/weather_app/data/data_provider/weather_data_provider.dart';
import 'package:dissertation_project_app/weather_app/data/repository/weather_repository.dart';

class AppRepositories extends StatelessWidget {
  final Widget child;

  const AppRepositories({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => WeatherRepository(WeatherDataProvider()),
        ),
      ],
      child: child,
    );
  }
}
