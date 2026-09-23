import 'dart:async';

import 'package:fitbodyrd_flutter/features/home/presentation/cubits/home_dashboard_cubit.dart';
import 'package:fitbodyrd_flutter/src/core/injections/injection_container.dart';

class DashboardRefreshService {
  Timer? _debounceTimer;
  static const Duration _debounceDuration = Duration(milliseconds: 1000);

  /// Triggers a debounced refresh of the home dashboard.
  /// If a refresh is already pending,
  /// it cancels the previous one and starts a new timer.
  void refreshDashboard() {
    // Cancel any existing timer
    _debounceTimer?.cancel();

    // Start a new debounce timer
    _debounceTimer = Timer(_debounceDuration, () {
      // Get the HomeDashboardCubit from service locator
      // and refresh without showing loading

      sl<HomeDashboardCubit>().loadDashboard(showLoading: false).ignore();
    });
  }

  /// Disposes the service and cancels any pending timers.
  void dispose() {
    _debounceTimer?.cancel();
    _debounceTimer = null;
  }
}
