import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/home/presentation/widgets/metric_card.dart';

import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';

class WeeklySummaryCard extends StatelessWidget {
  const WeeklySummaryCard({
    required this.summary,
    super.key,
  });

  final WeeklySummaryDto summary;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const KText.titleLarge('Resumen Semanal'),
            KSizedBox.s20(),
            Row(
              children: [
                Expanded(
                  child: MetricCard(
                    label: 'Entrenamientos Completados',
                    value:
                        '${summary.workoutsCompleted}/${summary.workoutsScheduled}',
                    icon: Icons.fitness_center,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MetricCard(
                    label: 'Días de Nutrición Registrados',
                    value: '${summary.nutritionDaysLogged}/7 días',
                    icon: Icons.restaurant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: MetricCard(
                    label: 'Ejercicios Registrados',
                    value: '${summary.totalExercisesLogged}',
                    icon: Icons.list,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MetricCard(
                    label: 'Comidas Registradas',
                    value: '${summary.totalMealsLogged}',
                    icon: Icons.fastfood,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
