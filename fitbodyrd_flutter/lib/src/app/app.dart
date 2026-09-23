import 'package:fitbodyrd_flutter/src/core/injections/injection_container.dart';
import 'package:fitbodyrd_flutter/src/core/style/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, _) {
        return MaterialApp.router(
          routeInformationProvider: sl<GoRouter>().routeInformationProvider,
          routeInformationParser: sl<GoRouter>().routeInformationParser,
          routerDelegate: sl<GoRouter>().routerDelegate,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
        );
      },
    );
  }
}
