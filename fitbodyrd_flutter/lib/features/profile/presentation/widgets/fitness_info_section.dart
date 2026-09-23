import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/profile/presentation/widgets/info_row.dart';
import 'package:fitbodyrd_flutter/src/core/extensions/enum_translations.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';

class FitnessInfoSection extends StatelessWidget {
  const FitnessInfoSection({required this.user, super.key});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const KText.headlineSmall('Información de Fitness'),
        KSizedBox.s15(),
        Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InfoRow(
                  label: 'Objetivo',
                  value: user.bodyGoal.displayName,
                  icon: Icons.flag_outlined,
                ),
                const Divider(),
                InfoRow(
                  label: 'Nivel de Actividad',
                  value: user.activityLevel.displayName,
                  icon: Icons.directions_run_outlined,
                ),
                const Divider(),
                InfoRow(
                  label: 'Experiencia',
                  value: user.experienceLevel.displayName,
                  icon: Icons.fitness_center_outlined,
                ),
                const Divider(),
                InfoRow(
                  label: 'Días por Semana',
                  value: '${user.daysPerWeekExercise} días',
                  icon: Icons.calendar_today_outlined,
                ),
                const Divider(),
                InfoRow(
                  label: 'Restricciones Dietéticas',
                  value: user.dietaryRestrictions.displayName,
                  icon: Icons.restaurant_outlined,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
