import 'package:fitbodyrd_flutter/src/core/routing/app_routes.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const KText.titleMedium('Acciones Rápidas'),
            const SizedBox(height: 16),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        context,
                        icon: Icons.restaurant,
                        label: 'Nutrición',
                        color: KColors.primary.p500,
                        onTap: () => context.go('/nutrition'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildActionButton(
                        context,
                        icon: Icons.fitness_center,
                        label: 'Entrenamientos',
                        color: KColors.primary.p500,
                        onTap: () => context.go('/exercises'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: _buildActionButton(
                    context,
                    icon: Icons.history,
                    label: 'Historial de Ejercicios',
                    color: KColors.primary.p500,
                    onTap: () =>
                        context.pushNamed(AppRoutes.workoutHistory.name),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            KText.bodyMedium(
              label,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
