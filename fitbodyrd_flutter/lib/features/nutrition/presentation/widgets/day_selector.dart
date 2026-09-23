import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DaySelector extends StatelessWidget {
  const DaySelector({
    required this.selectedDate,
    required this.onDateSelected,
    required this.startDate,
    super.key,
    this.daysToShow = 7,
  });
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final DateTime startDate;
  final int daysToShow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: daysToShow,
        itemBuilder: (context, index) {
          final date = startDate.add(Duration(days: index));
          final isSelected = _isSameDay(date, selectedDate);

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? KColors.primary.p500 : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? KColors.primary.p500
                      : KColors.greyScale.g500,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KText.bodySmall(
                    DateFormat('E', 'es').format(date).toUpperCase(),
                    color: isSelected ? Colors.black : KColors.greyScale.g500,
                  ),
                  const SizedBox(height: 4),
                  KText.titleMedium(
                    date.day.toString(),
                    color: isSelected ? Colors.black : KColors.greyScale.g500,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
