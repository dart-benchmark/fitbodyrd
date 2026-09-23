import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/workout_history_cubit.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/widgets/exercise_stats_time_selector.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/widgets/workout_progress_widgets.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/widgets/workout_session_details.dart';
import 'package:fitbodyrd_flutter/src/core/injections/injection_container.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutHistoryScreen extends StatelessWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WorkoutHistoryCubit>(),
      child: const WorkoutHistoryView(),
    );
  }
}

class WorkoutHistoryView extends StatelessWidget {
  const WorkoutHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const KText.headlineSmall('Historial de Entrenamientos'),
        actions: [
          BlocBuilder<WorkoutHistoryCubit, WorkoutHistoryState>(
            builder: (context, state) {
              if (state is WorkoutHistoryLoaded) {
                return IconButton(
                  icon: Icon(
                    state.viewMode == WorkoutHistoryViewMode.list
                        ? Icons.calendar_today
                        : Icons.list,
                  ),
                  onPressed: () {
                    context.read<WorkoutHistoryCubit>().toggleViewMode();
                  },
                  tooltip: state.viewMode == WorkoutHistoryViewMode.list
                      ? 'Ver calendario'
                      : 'Ver lista',
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<WorkoutHistoryCubit, WorkoutHistoryState>(
          builder: (context, state) {
            if (state is WorkoutHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is WorkoutHistoryError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: KColors.status.error,
                    ),
                    KSizedBox.s20(),
                    KText.bodyLarge(
                      state.message,
                      color: KColors.status.error,
                    ),
                    KSizedBox.s20(),
                    ElevatedButton(
                      onPressed: () async {
                        await context
                            .read<WorkoutHistoryCubit>()
                            .loadWorkoutHistory();
                      },
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              );
            }

            if (state is WorkoutHistoryLoaded) {
              if (state.sessionsByDate.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.fitness_center,
                        size: 64,
                        color: KColors.greyScale.g400,
                      ),
                      KSizedBox.s20(),
                      KText.bodyLarge(
                        'No hay historial de entrenamientos',
                        color: KColors.greyScale.g600,
                      ),
                      KSizedBox.s10(),
                      KText.bodyMedium(
                        'Comienza a entrenar para ver tu progreso aquí',
                        color: KColors.greyScale.g500,
                      ),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress Metrics
                    WorkoutProgressMetricsCards(
                      metrics: state.progressMetrics,
                    ),
                    KSizedBox.s20(),

                    // Time Period Selector
                    ExerciseStatsTimeSelector(
                      selectedPeriod: state.selectedPeriod,
                      onPeriodSelected: (period) async {
                        await context
                            .read<WorkoutHistoryCubit>()
                            .updatePeriod(period);
                      },
                    ),
                    KSizedBox.s20(),

                    // Frequency Chart
                    WorkoutFrequencyChart(
                      sessionsByDate: state.sessionsByDate,
                    ),
                    KSizedBox.s20(),

                    // Sessions List
                    const KText.titleMedium('Sesiones de Entrenamiento'),
                    KSizedBox.s10(),

                    if (state.viewMode == WorkoutHistoryViewMode.list)
                      ...state.sessionsByDate.map((sessionGroup) {
                        return Column(
                          children:
                              sessionGroup.sessions.map<Widget>((session) {
                            return WorkoutSessionDetails(session: session);
                          }).toList(),
                        );
                      })
                    else
                      // Calendar view placeholder - can be enhanced later
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: KText.bodyMedium(
                              'Vista de calendario - Próximamente',
                              color: KColors.greyScale.g600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
