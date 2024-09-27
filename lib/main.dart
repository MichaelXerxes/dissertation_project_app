import 'package:dissertation_project_app/home_page.dart';
import 'package:dissertation_project_app/main_utils/app_repositories/app_repositories.dart';
import 'package:dissertation_project_app/main_utils/app_routes/app_routes.dart';
import 'package:dissertation_project_app/main_utils/bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';

//final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return AppRepositories(
        child: AppBlocProviders(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: '/home_page',
        routes: AppRoutes.routes,
        home: Scaffold(
          body: Center(child: HomePage(title: "")),
        ),
      ),
    ));
  }
}
