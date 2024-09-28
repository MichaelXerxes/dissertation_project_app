import 'package:dissertation_project_app/feature/services/to_do_list/screens/add_item_page.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/screens/to_do_page.dart';
import 'package:flutter/material.dart';
import 'package:dissertation_project_app/home_page.dart';

import 'package:dissertation_project_app/weather_app/weather_page.dart';

class AppRoutes {
  static const String homePage = '/home_page';
  static const String toDoPage = '/services/to_do_list/screens/to_do_page';
  static const String addItemPage =
      '/services/to_do_list/screens/add_item_page';
  static const String weatherPage = '/weather_app/weather_page';

  static final routes = <String, WidgetBuilder>{
    homePage: (context) => const HomePage(title: "Home Page"),
    toDoPage: (context) => const ToDoPage(),
    addItemPage: (context) => AddItemPage(),
    weatherPage: (context) => WeatherPage(),
  };
}
