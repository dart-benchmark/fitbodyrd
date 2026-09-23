import 'dart:async';

import 'package:fitbodyrd_flutter/features/nutrition/presentation/cubits/nutrition_dashboard_cubit.dart';

import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/workout_dashboard_cubit.dart';
import 'package:fitbodyrd_flutter/src/core/injections/injection_container.dart';

/// Service to preload data for nutrition and workout tabs in the background.
/// This ensures faster tab switching by loading data
/// before users navigate to those tabs.
class TabPreloadService {
  /// Preloads data for both nutrition and workout tabs.
  static Future<void> preloadTabs() async {
    // Preload nutrition tab data
    unawaited(_preloadNutrition());

    // Preload workout tab data
    unawaited(_preloadWorkout());
  }

  /// Preloads nutrition dashboard data.
  static Future<void> _preloadNutrition() async {
    final cubit = sl<NutritionDashboardCubit>();
    await cubit.loadDashboard();
  }

  /// Preloads workout dashboard data.
  static Future<void> _preloadWorkout() async {
    final cubit = sl<WorkoutDashboardCubit>();
    await cubit.loadDashboard();
  }
}
