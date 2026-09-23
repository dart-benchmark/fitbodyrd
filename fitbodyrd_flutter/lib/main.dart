import 'dart:developer';

import 'package:fitbodyrd_flutter/src/app/app.dart';
import 'package:fitbodyrd_flutter/src/core/injections/injection_container.dart';
import 'package:fitbodyrd_flutter/src/core/observers/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Restrict to portrait orientation only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await injectDependencies();
  await initializeDateFormatting();

  Bloc.observer = AppBlocObserver();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    log(
      'Flutter Error: ${details.exceptionAsString()}',
      stackTrace: details.stack,
      error: details.exception,
    );
  };

  runApp(const MainApp());
}
