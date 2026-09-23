import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';

class ExerciseStatsSummary extends StatelessWidget {
  const ExerciseStatsSummary({
    required this.logs,
    super.key,
  });

  final List<ExerciseLog> logs;

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
      return const SizedBox.shrink();
    }

    final stats = _calculateStats(logs);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const KText.titleMedium('Resumen de Estadísticas'),
            KSizedBox.s20(),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildStatCard(
                  'Total de Sesiones',
                  '${stats.totalSessions}',
                  Icons.fitness_center,
                ),
                if (stats.maxWeight != null)
                  _buildStatCard(
                    'Peso Máximo',
                    '${stats.maxWeight!.toStringAsFixed(1)} kg',
                    Icons.trending_up,
                  ),
                _buildStatCard(
                  'Reps Promedio',
                  stats.avgReps.toStringAsFixed(1),
                  Icons.repeat,
                ),
                _buildStatCard(
                  'Series Promedio',
                  stats.avgSets.toStringAsFixed(1),
                  Icons.list,
                ),
                if (stats.avgDifficulty != null)
                  _buildStatCard(
                    'Dificultad Promedio',
                    '${stats.avgDifficulty!.toStringAsFixed(1)}/5',
                    Icons.star,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: KColors.greyScale.g900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: KColors.primary.p500),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText.bodySmall(
                label,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              KText.bodyMedium(
                value,
                fontWeight: FontWeight.bold,
                color: KColors.primary.p500,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _Stats _calculateStats(List<ExerciseLog> logs) {
    final totalSessions = logs.length;
    double? maxWeight;
    double totalReps = 0;
    double totalSets = 0;
    double? totalDifficulty;
    var difficultyCount = 0;

    for (final log in logs) {
      if (log.weightUsed != null) {
        maxWeight = maxWeight == null
            ? log.weightUsed!
            : (maxWeight > log.weightUsed! ? maxWeight : log.weightUsed!);
      }
      totalReps += log.repsCompleted;
      totalSets += log.setsCompleted;
      if (log.difficultyRating != null) {
        totalDifficulty = (totalDifficulty ?? 0) + log.difficultyRating!;
        difficultyCount++;
      }
    }

    return _Stats(
      totalSessions: totalSessions,
      maxWeight: maxWeight,
      avgReps: totalSessions > 0 ? totalReps / totalSessions : 0,
      avgSets: totalSessions > 0 ? totalSets / totalSessions : 0,
      avgDifficulty:
          difficultyCount > 0 ? totalDifficulty! / difficultyCount : null,
    );
  }
}

class _Stats {
  _Stats({
    required this.totalSessions,
    required this.avgReps,
    required this.avgSets,
    this.maxWeight,
    this.avgDifficulty,
  });

  final int totalSessions;
  final double? maxWeight;
  final double avgReps;
  final double avgSets;
  final double? avgDifficulty;
}
