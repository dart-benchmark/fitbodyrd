import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:flutter/material.dart';

/// Returns a color based on the percentage of target achieved.
///
/// Color ranges:
/// - Green (Success): 90-110% of target
/// - Yellow (Warning): 70-90% or 110-130% of target
/// - Red (Error): <70% or >130% of target
///
/// [percentage] should be a value between 0.0 and 1.0+ representing
/// consumed/target ratio (e.g., 0.85 for 85%, 1.2 for 120%).
Color getProgressColor(double percentage) {
  if (percentage >= 0.9 && percentage <= 1.1) {
    // Green: 90-110% - Good range
    return KColors.status.success;
  } else if ((percentage >= 0.7 && percentage < 0.9) ||
      (percentage > 1.1 && percentage <= 1.3)) {
    // Yellow: 70-90% or 110-130% - Warning range
    return KColors.status.warning;
  } else {
    // Red: <70% or >130% - Error range
    return KColors.status.error;
  }
}

/// Returns a message based on the percentage of target achieved.
///
/// [percentage] should be a value between 0.0 and 1.0+ representing
/// consumed/target ratio (e.g., 0.85 for 85%, 1.2 for 120%).
String getProgressMessage(double percentage) {
  if (percentage >= 0.9 && percentage <= 1.1) {
    // Perfect range: 90-110%
    return '¡Perfecto! Has alcanzado tu meta';
  } else if (percentage >= 0.7 && percentage < 0.9) {
    // Warning low: 70-90%
    return 'Te falta un poco, sigue así';
  } else if (percentage > 1.1 && percentage <= 1.3) {
    // Warning high: 110-130%
    return 'Has comido un poco de más';
  } else if (percentage < 0.7) {
    // Error low: <70%
    return 'Has comido muy poco, intenta comer más';
  } else {
    // Error high: >130%
    return 'Has comido demasiado, intenta reducir';
  }
}
