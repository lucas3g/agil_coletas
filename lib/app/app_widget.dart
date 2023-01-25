import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:agil_coletas/app/utils/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Modular.setNavigatorKey(NavigationService.navigatorKey);

    return MaterialApp.router(
      title: 'Ágil Coletas',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: AppTheme.colors.primary,
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppTheme.colors.primary,
          foregroundColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          color: AppTheme.colors.primary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
