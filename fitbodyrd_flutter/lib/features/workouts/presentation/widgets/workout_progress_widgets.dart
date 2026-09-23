import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkoutProgressMetricsCards extends StatelessWidget {
  const WorkoutProgressMetricsCards({
    required this.metrics,
    super.key,
  });

  final WorkoutProgressMetricsDto metrics;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const KText.titleMedium('Métricas de Progreso'),
            KSizedBox.s20(),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildMetricCard(
                  'Total Entrenamientos',
                  '${metrics.totalWorkoutsCompleted}',
                  Icons.fitness_center,
                ),
                _buildMetricCard(
                  'Racha Actual',
                  '${metrics.currentStreak} días',
                  Icons.local_fire_department,
                  color: metrics.currentStreak > 0
                      ? KColors.primary.p500
                      : KColors.greyScale.g600,
                ),
                _buildMetricCard(
                  'Racha Más Larga',
                  '${metrics.longestStreak} días',
                  Icons.trending_up,
                ),
                _buildMetricCard(
                  'Promedio/Semana',
                  metrics.averageWorkoutsPerWeek.toStringAsFixed(1),
                  Icons.calendar_today,
                ),
                _buildMetricCard(
                  'Esta Semana',
                  '${metrics.workoutsThisWeek}',
                  Icons.date_range,
                ),
                _buildMetricCard(
                  'Este Mes',
                  '${metrics.workoutsThisMonth}',
                  Icons.calendar_month,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: KColors.greyScale.g900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: color ?? KColors.primary.p500,
          ),
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
                color: color ?? KColors.primary.p500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WorkoutFrequencyChart extends StatelessWidget {
  const WorkoutFrequencyChart({
    required this.sessionsByDate,
    super.key,
  });

  final List<WorkoutSessionsByDateDto> sessionsByDate;

  @override
  Widget build(BuildContext context) {
    if (sessionsByDate.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.bar_chart,
                  size: 48,
                  color: KColors.greyScale.g400,
                ),
                KSizedBox.s10(),
                KText.bodyMedium(
                  'No hay datos disponibles para mostrar',
                  color: KColors.greyScale.g600,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Group by week
    final weeklyData = _groupByWeek(sessionsByDate);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const KText.titleMedium('Frecuencia de Entrenamientos'),
            KSizedBox.s20(),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: weeklyData.values
                          .reduce((a, b) => a > b ? a : b)
                          .toDouble() +
                      2,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) => KColors.primary.p700,
                      tooltipPadding: const EdgeInsets.all(8),
                      tooltipMargin: 8,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${rod.toY.toInt()} entrenamientos'
                          '\n${weeklyData.keys.elementAt(groupIndex)}',
                          TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < weeklyData.length) {
                            final weekLabel =
                                weeklyData.keys.elementAt(value.toInt());
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                weekLabel,
                                style: TextStyle(
                                  color: KColors.greyScale.g600,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          }
                          return const Text('');
                        },
                        reservedSize: 40,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              color: KColors.greyScale.g600,
                              fontSize: 10,
                            ),
                          );
                        },
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    drawVerticalLine: false,
                    horizontalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: KColors.greyScale.g200,
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups:
                      weeklyData.entries.toList().asMap().entries.map((entry) {
                    final index = entry.key;
                    final count = entry.value.value.toDouble();
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: count,
                          color: KColors.primary.p500,
                          width: 16,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, int> _groupByWeek(List<WorkoutSessionsByDateDto> sessions) {
    final weeklyData = <String, int>{};

    for (final sessionGroup in sessions) {
      final date = sessionGroup.date;
      final weekStart = _getMondayOfWeek(date);
      final weekStartFormatted = DateFormat('MM/dd', 'es').format(weekStart);
      final weekEndFormatted = DateFormat('MM/dd', 'es')
          .format(weekStart.add(const Duration(days: 6)));
      final weekLabel = '$weekStartFormatted - $weekEndFormatted';

      weeklyData[weekLabel] =
          (weeklyData[weekLabel] ?? 0) + sessionGroup.sessions.length;
    }

    // Sort by date (most recent first)
    final sortedEntries = weeklyData.entries.toList()
      ..sort((a, b) {
        // Extract first date from label for sorting
        final aDate = a.key.split(' - ')[0];
        final bDate = b.key.split(' - ')[0];
        return DateFormat('MM/dd', 'es').parse(bDate).compareTo(
              DateFormat('MM/dd', 'es').parse(aDate),
            );
      });

    // Take last 8 weeks for display
    final recentWeeks = sortedEntries.take(8).toList();
    final result = <String, int>{};
    for (var i = 0; i < recentWeeks.length; i++) {
      result[recentWeeks[i].key] = recentWeeks[i].value;
    }

    return result;
  }

  DateTime _getMondayOfWeek(DateTime date) {
    final dayOfWeek = date.weekday;
    final daysToSubtract = dayOfWeek - 1;
    return DateTime(date.year, date.month, date.day)
        .subtract(Duration(days: daysToSubtract));
  }
}
