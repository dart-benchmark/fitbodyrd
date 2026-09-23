import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<Object?> bloc) {
    super.onCreate(bloc);
    log(
      'CC: ${bloc.runtimeType}',
      name: 'BlocObserver',
    );
  }

  @override
  void onChange(BlocBase<Object?> bloc, Change<Object?> change) {
    super.onChange(bloc, change);
    log(
      'SC: ${bloc.runtimeType}\n'
      '  P: ${change.currentState?.runtimeType}\n'
      '  N: ${change.nextState?.runtimeType}',
      name: 'BlocObserver',
    );
  }

  @override
  void onClose(BlocBase<Object?> bloc) {
    super.onClose(bloc);
    log(
      'CD: ${bloc.runtimeType}',
      name: 'BlocObserver',
    );
  }
}
