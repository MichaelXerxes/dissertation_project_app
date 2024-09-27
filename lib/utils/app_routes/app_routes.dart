import 'package:flutter/material.dart';
import 'package:dissertation_project_app/home_page.dart';

import 'package:dissertation_project_app/weather_app/weather_page.dart';

class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    '/home_page': (context) => const HomePage(title: "Home Page"),
    // '/to_do_list_app/todo_list': (context) => const TodoList(),
    // '/to_do_list_app/add_todo_page': (context) => const AddTodoPage(),
    // '/sign_in_app/login_page': (context) => const LoginScreen(),
    // '/sign_in_app/user_detail': (context) => const UserDetail(),
    '/weather_app/weather_page': (context) => WeatherPage(),
  };
}
