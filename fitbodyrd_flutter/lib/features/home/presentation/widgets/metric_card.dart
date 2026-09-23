import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  const MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    super.key,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: KColors.greyScale.g900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: KColors.primary.p500),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText.bodySmall(
                  label,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 4),
                KText.titleMedium(
                  value,
                  fontWeight: FontWeight.bold,
                  color: KColors.primary.p500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
