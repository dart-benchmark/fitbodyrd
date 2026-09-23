import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: KColors.primary.p500,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText.bodySmall(
                  label,
                  color: KColors.greyScale.g600,
                ),
                const SizedBox(height: 4),
                KText.bodyMedium(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
