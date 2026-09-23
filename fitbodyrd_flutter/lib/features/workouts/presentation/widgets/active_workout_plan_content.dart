import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/widgets/day_selector.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/workout_dashboard_cubit.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/widgets/log_exercise_dialog.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/widgets/session_completed_dialog.dart';
import 'package:fitbodyrd_flutter/src/core/routing/app_routes.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActiveWorkoutPlanContent extends StatelessWidget {
  const ActiveWorkoutPlanContent({
    required this.state,
    super.key,
  });

  final WorkoutDashboardLoaded state;

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutDashboardCubit, WorkoutDashboardState>(
      listener: (context, state) async {
        if (state is WorkoutDashboardLoaded && state.sessionJustCompleted) {
          // Show the completion dialog
          await showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (context) => const SessionCompletedDialog(),
          ).then((_) {
            // Reset the flag after dialog is dismissed
            if (context.mounted) {
              context.read<WorkoutDashboardCubit>().clearSessionCompletedFlag();
            }
          });
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: DaySelector(
              selectedDate: state.selectedDate,
              startDate: state.plan.startDate,
              daysToShow:
                  state.plan.endDate.difference(state.plan.startDate).inDays +
                      1, // +1 to include the end date
              onDateSelected: (date) async {
                await context.read<WorkoutDashboardCubit>().selectDate(date);
              },
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: _buildContent(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (state.currentSession == null) {
      return Center(
        key: ValueKey(state.selectedDate.toString()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.self_improvement,
              size: 64,
              color: KColors.primary.p500,
            ),
            KSizedBox.s20(),
            const KText.headlineSmall('¡Día de Descanso!'),
            KSizedBox.s10(),
            const KText.bodyMedium(
              'Tu cuerpo necesita recuperarse.\nDisfruta tu día libre.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final session = state.currentSession!;

    DateTime dateOnly(DateTime date) =>
        DateTime(date.year, date.month, date.day);

    return CustomScrollView(
      key: ValueKey(state.selectedDate.toString()),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText.headlineSmall(
                  session.focus,
                  color: KColors.primary.p500,
                ),
                if (session.notes != null) ...[
                  KSizedBox.s10(),
                  KText.bodySmall(session.notes!),
                ],
                KSizedBox.s20(),
                KText.titleMedium(
                  'Ejercicios (${session.exercises?.length ?? 0})',
                ),
              ],
            ),
          ),
        ),
        if (session.exercises != null && session.exercises!.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final exercise = session.exercises![index];

                final dateKey = dateOnly(state.selectedDate);
                final logsForDate =
                    state.logsByDateAndExercise[dateKey] ?? const {};
                final logForDate = logsForDate[exercise.exerciseId];

                final isCompleted = logForDate != null;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isCompleted
                          ? KColors.primary.p500
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: ListTile(
                    leading: IconButton(
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          isCompleted
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          key: ValueKey(isCompleted),
                          color: isCompleted
                              ? KColors.primary.p500
                              : KColors.greyScale.g400,
                          size: 28,
                        ),
                      ),
                      onPressed: () async {
                        if (logForDate != null) {
                          await context
                              .read<WorkoutDashboardCubit>()
                              .deleteLogForExercise(logForDate);
                          return;
                        }

                        final result = await showDialog<ExerciseLog?>(
                          context: context,
                          builder: (context) => LogExerciseDialog(
                            workoutExercise: exercise,
                            selectedDate: state.selectedDate,
                            existingLog: logForDate,
                          ),
                        );

                        if (result != null && context.mounted) {
                          await context
                              .read<WorkoutDashboardCubit>()
                              .applyOrUpdateLog(result);
                        }
                      },
                    ),
                    title: KText.titleSmall(
                      exercise.exercise?.name ?? 'Ejercicio',
                    ),
                    subtitle: isCompleted
                        ? KText.bodySmall(
                            () {
                              final weightText = logForDate.weightUsed != null
                                  ? ' • ${logForDate.weightUsed}kg'
                                  : '';
                              return 'Completado: '
                                  '${logForDate.setsCompleted} series x '
                                  '${logForDate.repsCompleted} reps'
                                  '$weightText';
                            }(),
                            color: KColors.primary.p500,
                          )
                        : KText.bodySmall(
                            '${exercise.sets} series x '
                            '${exercise.reps} reps • '
                            '${exercise.restSeconds}s descanso',
                          ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      await context.pushNamed(
                        AppRoutes.exerciseDetails.name,
                        extra: exercise,
                      );
                    },
                  ),
                );
              },
              childCount: session.exercises!.length,
            ),
          )
        else
          const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: KText.bodyMedium('No hay ejercicios en esta sesión.'),
              ),
            ),
          ),
      ],
    );
  }
}
