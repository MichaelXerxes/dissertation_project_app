import 'package:dissertation_project_app/core/storage_hive/hive_register_adapter.dart';
import 'package:dissertation_project_app/core/theme/text_styles.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/data/to_do_hive/to_do_data_hive.dart';
import 'package:dissertation_project_app/home_page.dart';
import 'package:dissertation_project_app/core/main_utils/app_repositories/app_repositories.dart';
import 'package:dissertation_project_app/core/main_utils/app_routes/app_routes.dart';
import 'package:dissertation_project_app/core/main_utils/bloc_provider/bloc_provider.dart';
import 'package:dissertation_project_app/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  tz.initializeTimeZones();

  await HiveRegisterAdapter.register();

  Bloc.observer = AppBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return
      // AppRepositories(
      //   child:
        AppBlocProviders(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: '/home_page',
        theme: customTheme,
        // localizationsDelegates: AppLocalizations.localizationsDelegates,
        // supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        routes: AppRoutes.routes,
        home: Scaffold(
          body: Center(child: HomePage(title: "")),
        ),
      ),
    //)
    );
  }
}
