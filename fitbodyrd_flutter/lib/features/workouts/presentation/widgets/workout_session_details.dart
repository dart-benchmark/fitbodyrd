import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/src/core/routing/app_routes.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class WorkoutSessionDetails extends StatelessWidget {
  const WorkoutSessionDetails({
    required this.session,
    super.key,
  });

  final WorkoutSession session;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        leading: Icon(
          Icons.fitness_center,
          color: KColors.primary.p500,
        ),
        title: KText.titleSmall(
          DateFormat('EEEE, d MMMM y', 'es').format(session.date),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KSizedBox.s5(),
            if (session.focus.isNotEmpty)
              KText.bodySmall(
                'Enfoque: ${session.focus}',
                color: KColors.greyScale.g600,
              ),
            if (session.exercises != null && session.exercises!.isNotEmpty)
              KText.bodySmall(
                '${session.exercises!.length} ejercicios',
                color: KColors.greyScale.g600,
              ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (session.focus.isNotEmpty) ...[
                  _buildInfoRow(
                    context,
                    'Enfoque',
                    session.focus,
                    Icons.gps_fixed,
                  ),
                  KSizedBox.s10(),
                ],
                if (session.dayName.isNotEmpty) ...[
                  _buildInfoRow(
                    context,
                    'Día',
                    session.dayName,
                    Icons.calendar_today,
                  ),
                  KSizedBox.s10(),
                ],
                if (session.exercises != null &&
                    session.exercises!.isNotEmpty) ...[
                  const Divider(),
                  KSizedBox.s10(),
                  const KText.titleSmall('Ejercicios'),
                  KSizedBox.s10(),
                  ...session.exercises!.map((exercise) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _buildExerciseItem(context, exercise),
                    );
                  }),
                ],
                if (session.notes != null && session.notes!.isNotEmpty) ...[
                  KSizedBox.s10(),
                  const Divider(),
                  KSizedBox.s10(),
                  const KText.titleSmall('Notas'),
                  KSizedBox.s5(),
                  KText.bodyMedium(session.notes!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: KColors.primary.p700),
        KSizedBox.s10(),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontSize: 14),
                ),
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExerciseItem(BuildContext context, WorkoutExercise exercise) {
    return InkWell(
      onTap: () async {
        await context.pushNamed(
          AppRoutes.exerciseDetails.name,
          extra: exercise,
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: KColors.greyScale.g900,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText.bodyMedium(
                    exercise.exercise?.name ?? 'Ejercicio',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  KSizedBox.s5(),
                  Wrap(
                    spacing: 12,
                    children: [
                      _buildExerciseStat(
                        '${exercise.sets} series',
                        Icons.repeat,
                      ),
                      _buildExerciseStat(
                        '${exercise.reps} reps',
                        Icons.fitness_center,
                      ),
                      if (exercise.restSeconds > 0)
                        _buildExerciseStat(
                          '${exercise.restSeconds}s',
                          Icons.timer,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: KColors.greyScale.g400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseStat(String text, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: KColors.primary.p500),
        const SizedBox(width: 4),
        KText.bodySmall(
          text,
          color: KColors.greyScale.g400,
        ),
      ],
    );
  }
}
