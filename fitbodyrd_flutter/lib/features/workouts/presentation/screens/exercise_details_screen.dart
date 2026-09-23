import 'dart:async';

import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/exercise_details_cubit.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/widgets/exercise_stats_charts.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/widgets/exercise_stats_summary.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/widgets/exercise_stats_time_selector.dart';
import 'package:fitbodyrd_flutter/src/core/extensions/enum_translations.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseDetailsScreen extends StatefulWidget {
  const ExerciseDetailsScreen({
    required this.workoutExercise,
    super.key,
  });

  final WorkoutExercise workoutExercise;

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  TimePeriod _selectedPeriod = TimePeriod.last3Months;

  @override
  void initState() {
    super.initState();
    // Load logs when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final exerciseId = widget.workoutExercise.exerciseId;
      final startDate = ExerciseStatsTimeSelector.getStartDate(_selectedPeriod);
      final endDate = DateTime.now();
      unawaited(
        context.read<ExerciseDetailsCubit>().loadExerciseLogs(
              exerciseId: exerciseId,
              startDate: startDate,
              endDate: endDate,
            ),
      );
    });
  }

  void _onPeriodSelected(TimePeriod period) {
    setState(() {
      _selectedPeriod = period;
    });
    final exerciseId = widget.workoutExercise.exerciseId;
    final startDate = ExerciseStatsTimeSelector.getStartDate(period);
    final endDate = DateTime.now();
    unawaited(
      context.read<ExerciseDetailsCubit>().updateDateRange(
            exerciseId: exerciseId,
            startDate: startDate,
            endDate: endDate,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.workoutExercise.exercise;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          exercise?.name ?? 'Detalles del Ejercicio',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: KColors.primary.p500,
              ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: exercise == null
          ? const Center(
              child: KText.bodyMedium('No hay información disponible.'),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Workout details card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const KText.titleMedium('Tu Entrenamiento'),
                          KSizedBox.s20(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatColumn(
                                'Series',
                                '${widget.workoutExercise.sets}',
                                Icons.repeat,
                              ),
                              _buildStatColumn(
                                'Reps',
                                '${widget.workoutExercise.reps}',
                                Icons.fitness_center,
                              ),
                              _buildStatColumn(
                                'Descanso',
                                '${widget.workoutExercise.restSeconds}s',
                                Icons.timer,
                              ),
                            ],
                          ),
                          if (widget.workoutExercise.notes != null) ...[
                            KSizedBox.s20(),
                            const Divider(),
                            KSizedBox.s10(),
                            const KText.titleSmall('Notas'),
                            KSizedBox.s5(),
                            KText.bodyMedium(widget.workoutExercise.notes!),
                          ],
                        ],
                      ),
                    ),
                  ),
                  KSizedBox.s20(),

                  // Description
                  if (exercise.description != null) ...[
                    const KText.titleMedium('Descripción'),
                    KSizedBox.s10(),
                    KText.bodyMedium(exercise.description!),
                    KSizedBox.s20(),
                  ],
                  // Muscle groups
                  const KText.titleMedium('Grupos Musculares'),
                  KSizedBox.s10(),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: exercise.muscleGroup
                        .map(
                          (mg) => Chip(
                            label: KText.bodySmall(
                              mg.displayName,
                              color: Colors.white,
                            ),
                            backgroundColor: KColors.primary.p700,
                          ),
                        )
                        .toList(),
                  ),
                  KSizedBox.s20(),
                  // Additional info
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            'Dificultad',
                            exercise.difficulty.displayName,
                            Icons.trending_up,
                          ),
                          if (exercise.requiresEquipment) ...[
                            KSizedBox.s10(),
                            _buildInfoRow(
                              'Equipo',
                              exercise.equipmentNeeded ?? 'Sí',
                              Icons.sports_gymnastics,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  KSizedBox.s20(),
                  // Statistics Section
                  const KText.titleMedium('Estadísticas'),
                  KSizedBox.s10(),
                  BlocBuilder<ExerciseDetailsCubit, ExerciseDetailsState>(
                    builder: (context, state) {
                      if (state is ExerciseDetailsLoading) {
                        return const Card(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      }
                      if (state is ExerciseDetailsError) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: KColors.status.error,
                                    size: 48,
                                  ),
                                  KSizedBox.s10(),
                                  KText.bodyMedium(
                                    state.message,
                                    color: KColors.status.error,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      if (state is ExerciseDetailsLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ExerciseStatsTimeSelector(
                              selectedPeriod: _selectedPeriod,
                              onPeriodSelected: _onPeriodSelected,
                            ),
                            KSizedBox.s20(),
                            ExerciseStatsSummary(logs: state.logs),
                            KSizedBox.s20(),
                            ExerciseStatsCharts(logs: state.logs),
                          ],
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                  KSizedBox.s20(),
                  // Images
                  if (exercise.images != null &&
                      exercise.images!.isNotEmpty) ...[
                    Builder(
                      builder: (context) {
                        // Filter out images with empty URLs
                        final validImages = exercise.images!
                            .where((img) => img.imageUrl.isNotEmpty)
                            .toList();
                        if (validImages.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return SizedBox(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: validImages.length,
                            itemBuilder: (context, index) {
                              final image = validImages[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    image.imageUrl,
                                    width: 250,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 250,
                                        decoration: BoxDecoration(
                                          color: KColors.greyScale.g200,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Icon(
                                          Icons.image_not_supported,
                                          size: 48,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    KSizedBox.s20(),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _buildStatColumn(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 32, color: KColors.primary.p700),
        KSizedBox.s10(),
        KText.headlineSmall(value),
        KSizedBox.s5(),
        KText.bodySmall(label, color: KColors.greyScale.g600),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: KColors.primary.p700),
        KSizedBox.s10(),
        KText.bodyMedium('$label: '),
        KText.bodyMedium(
          value,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
