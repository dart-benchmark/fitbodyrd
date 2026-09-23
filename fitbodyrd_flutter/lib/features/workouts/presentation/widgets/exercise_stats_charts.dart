import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExerciseStatsCharts extends StatelessWidget {
  const ExerciseStatsCharts({
    required this.logs,
    super.key,
  });

  final List<ExerciseLog> logs;

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Weight Chart (if available)
        if (_hasWeightData(logs)) ...[
          _buildChartCard(
            title: 'Progreso de Peso (kg)',
            child: _buildWeightChart(logs),
          ),
          KSizedBox.s20(),
        ],
        // Reps Chart
        _buildChartCard(
          title: 'Repeticiones Completadas',
          child: _buildRepsChart(logs),
        ),
        KSizedBox.s20(),
        // Sets Chart
        _buildChartCard(
          title: 'Series Completadas',
          child: _buildSetsChart(logs),
        ),
        KSizedBox.s20(),
        // Difficulty Chart (if available)
        if (_hasDifficultyData(logs)) ...[
          _buildChartCard(
            title: 'Calificación de Dificultad',
            child: _buildDifficultyChart(logs),
          ),
        ],
      ],
    );
  }

  bool _hasWeightData(List<ExerciseLog> logs) {
    return logs.any((log) => log.weightUsed != null);
  }

  bool _hasDifficultyData(List<ExerciseLog> logs) {
    return logs.any((log) => log.difficultyRating != null);
  }

  Widget _buildChartCard({
    required String title,
    required Widget child,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KText.titleMedium(title),
            KSizedBox.s20(),
            SizedBox(
              height: 200,
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightChart(List<ExerciseLog> logs) {
    final weightLogs = logs.where((log) => log.weightUsed != null).toList();
    if (weightLogs.isEmpty) {
      return const Center(
        child: Text('No hay datos de peso disponibles'),
      );
    }

    final spots = weightLogs.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        entry.value.weightUsed!,
      );
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval:
              _calculateInterval(spots.map((s) => s.y).toList()),
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: KColors.greyScale.g200,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < weightLogs.length) {
                  final date = weightLogs[value.toInt()].date;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      DateFormat('MM/dd', 'es').format(date),
                      style: TextStyle(
                        color: KColors.greyScale.g600,
                        fontSize: 10,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
              reservedSize: 30,
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
              reservedSize: 40,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: KColors.greyScale.g300,
            ),
            left: BorderSide(
              color: KColors.greyScale.g300,
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: KColors.primary.p600,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: KColors.primary.p600,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: KColors.primary.p200.withValues(alpha: 0.3),
            ),
          ),
        ],
        minY: _getMinValue(spots.map((s) => s.y).toList()) - 5,
        maxY: _getMaxValue(spots.map((s) => s.y).toList()) + 5,
      ),
    );
  }

  Widget _buildRepsChart(List<ExerciseLog> logs) {
    final spots = logs.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        entry.value.repsCompleted.toDouble(),
      );
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval:
              _calculateInterval(spots.map((s) => s.y).toList()),
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: KColors.greyScale.g200,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < logs.length) {
                  final date = logs[value.toInt()].date;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      DateFormat('MM/dd', 'es').format(date),
                      style: TextStyle(
                        color: KColors.greyScale.g600,
                        fontSize: 10,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
              reservedSize: 30,
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
              reservedSize: 40,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: KColors.greyScale.g300,
            ),
            left: BorderSide(
              color: KColors.greyScale.g300,
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: KColors.primary.p600,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: KColors.primary.p600,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: KColors.primary.p200.withValues(alpha: 0.3),
            ),
          ),
        ],
        minY: 0,
        maxY: _getMaxValue(spots.map((s) => s.y).toList()) + 5,
      ),
    );
  }

  Widget _buildSetsChart(List<ExerciseLog> logs) {
    final spots = logs.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        entry.value.setsCompleted.toDouble(),
      );
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval:
              _calculateInterval(spots.map((s) => s.y).toList()),
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: KColors.greyScale.g200,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < logs.length) {
                  final date = logs[value.toInt()].date;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      DateFormat('MM/dd', 'es').format(date),
                      style: TextStyle(
                        color: KColors.greyScale.g600,
                        fontSize: 10,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
              reservedSize: 30,
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
              reservedSize: 40,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: KColors.greyScale.g300,
            ),
            left: BorderSide(
              color: KColors.greyScale.g300,
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: KColors.primary.p600,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: KColors.primary.p600,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: KColors.primary.p200.withValues(alpha: 0.3),
            ),
          ),
        ],
        minY: 0,
        maxY: _getMaxValue(spots.map((s) => s.y).toList()) + 2,
      ),
    );
  }

  Widget _buildDifficultyChart(List<ExerciseLog> logs) {
    final difficultyLogs =
        logs.where((log) => log.difficultyRating != null).toList();
    if (difficultyLogs.isEmpty) {
      return const Center(
        child: Text('No hay datos de dificultad disponibles'),
      );
    }

    final spots = difficultyLogs.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        entry.value.difficultyRating!.toDouble(),
      );
    }).toList();

    return LineChart(
      LineChartData(
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
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 &&
                    value.toInt() < difficultyLogs.length) {
                  final date = difficultyLogs[value.toInt()].date;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      DateFormat('MM/dd', 'es').format(date),
                      style: TextStyle(
                        color: KColors.greyScale.g600,
                        fontSize: 10,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
              reservedSize: 30,
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
              reservedSize: 40,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: KColors.greyScale.g300,
            ),
            left: BorderSide(
              color: KColors.greyScale.g300,
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: KColors.primary.p600,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: KColors.primary.p600,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: KColors.primary.p200.withValues(alpha: 0.3),
            ),
          ),
        ],
        minY: 0,
        maxY: 5,
      ),
    );
  }

  double _getMinValue(List<double> values) {
    if (values.isEmpty) return 0;
    return values.reduce((a, b) => a < b ? a : b);
  }

  double _getMaxValue(List<double> values) {
    if (values.isEmpty) return 0;
    return values.reduce((a, b) => a > b ? a : b);
  }

  double _calculateInterval(List<double> values) {
    if (values.isEmpty) return 1;
    final max = _getMaxValue(values);
    final min = _getMinValue(values);
    final range = max - min;
    if (range <= 0) return 1;
    if (range <= 10) return 1;
    if (range <= 50) return 5;
    if (range <= 100) return 10;
    return (range / 5).ceilToDouble();
  }
}
