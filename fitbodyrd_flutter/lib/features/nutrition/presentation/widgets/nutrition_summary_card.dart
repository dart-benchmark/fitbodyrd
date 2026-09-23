import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:fitbodyrd_flutter/src/core/utils/nutrition_color_utils.dart';
import 'package:flutter/material.dart';

class NutritionSummaryCard extends StatelessWidget {
  const NutritionSummaryCard({
    required this.consumedCalories,
    required this.targetCalories,
    required this.consumedProtein,
    required this.targetProtein,
    required this.consumedCarbs,
    required this.targetCarbs,
    required this.consumedFat,
    required this.targetFat,
    super.key,
  });

  final double consumedCalories;
  final double targetCalories;
  final double consumedProtein;
  final double targetProtein;
  final double consumedCarbs;
  final double targetCarbs;
  final double consumedFat;
  final double targetFat;

  @override
  Widget build(BuildContext context) {
    final progress =
        targetCalories > 0 ? consumedCalories / targetCalories : 0.0;
    final progressColor = getProgressColor(progress);
    final progressMessage = getProgressMessage(progress);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: KColors.greyScale.g900,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Calories header
          KText.headlineMedium(
            '${consumedCalories.toStringAsFixed(0)} / ${targetCalories.toStringAsFixed(0)} kcal',
            color: progressColor,
          ),
          const SizedBox(height: 4),
          KText.bodySmall(
            'Kcal',
            color: KColors.greyScale.g400,
          ),
          const SizedBox(height: 8),
          KText.bodySmall(
            progressMessage,
            color: progressColor,
          ),
          const SizedBox(height: 16),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: KColors.greyScale.g700,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
          const SizedBox(height: 20),

          // Macros breakdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MacroColumn(
                label: 'Proteínas',
                consumed: consumedProtein,
                target: targetProtein,
                unit: 'g',
              ),
              _MacroColumn(
                label: 'Carbs',
                consumed: consumedCarbs,
                target: targetCarbs,
                unit: 'g',
              ),
              _MacroColumn(
                label: 'Grasas',
                consumed: consumedFat,
                target: targetFat,
                unit: 'g',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MacroColumn extends StatelessWidget {
  const _MacroColumn({
    required this.label,
    required this.consumed,
    required this.target,
    required this.unit,
  });

  final String label;
  final double consumed;
  final double target;
  final String unit;

  @override
  Widget build(BuildContext context) {
    final progress = target > 0 ? consumed / target : 0.0;
    final progressColor = getProgressColor(progress);

    return Column(
      children: [
        KText.bodySmall(
          label,
          color: KColors.greyScale.g400,
        ),
        const SizedBox(height: 8),
        KText.titleMedium(
          '${consumed.toStringAsFixed(0)} / ${target.toStringAsFixed(0)} $unit',
          color: progressColor,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
