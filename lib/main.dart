import 'package:dissertation_project_app/core/theme/text_styles.dart';
import 'package:dissertation_project_app/home_page.dart';
import 'package:dissertation_project_app/core/main_utils/app_repositories/app_repositories.dart';
import 'package:dissertation_project_app/core/main_utils/app_routes/app_routes.dart';
import 'package:dissertation_project_app/core/main_utils/bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        theme: customTheme,
        // localizationsDelegates: AppLocalizations.localizationsDelegates,
        // supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        routes: AppRoutes.routes,
        home: Scaffold(
          body: Center(child: HomePage(title: "")),
        ),
      ),
    ));
  }
}
