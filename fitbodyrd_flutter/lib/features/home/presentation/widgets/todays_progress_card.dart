import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:fitbodyrd_flutter/src/core/utils/nutrition_color_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TodaysProgressCard extends StatelessWidget {
  const TodaysProgressCard({
    required this.nutritionPlan,
    required this.workoutPlan,
    required this.todayCalories,
    required this.targetCalories,
    required this.hasWorkoutToday,
    required this.isWorkoutCompleted,
    super.key,
  });

  final NutritionPlan? nutritionPlan;
  final WorkoutPlan? workoutPlan;
  final double todayCalories;
  final double targetCalories;
  final bool hasWorkoutToday;
  final bool isWorkoutCompleted;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const KText.titleMedium('Progreso de Hoy'),
            const SizedBox(height: 16),
            if (nutritionPlan != null) ...[
              _buildNutritionProgress(context),
              const SizedBox(height: 16),
            ],
            if (workoutPlan != null) ...[
              _buildWorkoutProgress(context),
            ],
            if (nutritionPlan == null && workoutPlan == null)
              const KText.bodyMedium(
                'No hay planes activos. ¡Crea un plan para comenzar!',
                color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionProgress(BuildContext context) {
    final progress = targetCalories > 0 ? todayCalories / targetCalories : 0.0;
    final progressPercent = (progress * 100).clamp(0.0, 100.0);
    final progressColor = getProgressColor(progress);
    final progressMessage = getProgressMessage(progress);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.restaurant, size: 20, color: KColors.primary.p500),
                const SizedBox(width: 8),
                const KText.bodyMedium('Nutrición'),
              ],
            ),
            KText.bodyMedium(
              '${todayCalories.toStringAsFixed(0)} / ${targetCalories.toStringAsFixed(0)} kcal',
              fontWeight: FontWeight.bold,
              color: progressColor,
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 8,
            backgroundColor: KColors.greyScale.g800,
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
        ),
        const SizedBox(height: 4),
        KText.bodySmall(
          '${progressPercent.toStringAsFixed(0)}% completado',
          color: Colors.grey,
        ),
        const SizedBox(height: 4),
        KText.bodySmall(
          progressMessage,
          color: progressColor,
        ),
      ],
    );
  }

  Widget _buildWorkoutProgress(BuildContext context) {
    if (!hasWorkoutToday) {
      return Row(
        children: [
          Icon(Icons.fitness_center, size: 20, color: KColors.greyScale.g600),
          const SizedBox(width: 8),
          const Expanded(
            child: KText.bodyMedium(
              'Día de descanso',
              color: Colors.grey,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  isWorkoutCompleted
                      ? Icons.check_circle
                      : Icons.fitness_center,
                  size: 20,
                  color:
                      isWorkoutCompleted ? Colors.green : KColors.primary.p500,
                ),
                const SizedBox(width: 8),
                KText.bodyMedium(
                  isWorkoutCompleted
                      ? 'Entrenamiento completado'
                      : 'Entrenamiento pendiente',
                  color: isWorkoutCompleted ? Colors.green : null,
                ),
              ],
            ),
            if (!isWorkoutCompleted)
              TextButton(
                onPressed: () => context.go('/exercises'),
                child: const Text('Ver'),
              ),
          ],
        ),
      ],
    );
  }
}
