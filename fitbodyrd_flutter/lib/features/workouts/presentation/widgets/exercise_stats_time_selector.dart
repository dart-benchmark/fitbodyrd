import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';

enum TimePeriod {
  last30Days,
  last3Months,
  last6Months,
  lastYear,
  allTime,
}

class ExerciseStatsTimeSelector extends StatelessWidget {
  const ExerciseStatsTimeSelector({
    required this.selectedPeriod,
    required this.onPeriodSelected,
    super.key,
  });

  final TimePeriod selectedPeriod;
  final ValueChanged<TimePeriod> onPeriodSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const KText.titleSmall('Período de Tiempo'),
            KSizedBox.s10(),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildPeriodButton(
                  '30 días',
                  TimePeriod.last30Days,
                ),
                _buildPeriodButton(
                  '3 meses',
                  TimePeriod.last3Months,
                ),
                _buildPeriodButton(
                  '6 meses',
                  TimePeriod.last6Months,
                ),
                _buildPeriodButton(
                  '1 año',
                  TimePeriod.lastYear,
                ),
                _buildPeriodButton(
                  'Todo',
                  TimePeriod.allTime,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodButton(String label, TimePeriod period) {
    final isSelected = selectedPeriod == period;
    return ChoiceChip(
      label: KText.bodySmall(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          onPeriodSelected(period);
        }
      },
      selectedColor: KColors.primary.p600,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : KColors.greyScale.g700,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: KColors.greyScale.g200,
    );
  }

  static DateTime getStartDate(TimePeriod period) {
    final now = DateTime.now();
    switch (period) {
      case TimePeriod.last30Days:
        return now.subtract(const Duration(days: 30));
      case TimePeriod.last3Months:
        return DateTime(now.year, now.month - 3);
      case TimePeriod.last6Months:
        return DateTime(now.year, now.month - 6);
      case TimePeriod.lastYear:
        return DateTime(now.year - 1, now.month);
      case TimePeriod.allTime:
        return DateTime(2000); // Very old date to get all logs
    }
  }
}
