import 'dart:async';

import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/workout_dashboard_cubit.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/workout_generation_cubit.dart';
import 'package:fitbodyrd_flutter/src/core/common/components/c_button.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:fitbodyrd_flutter/src/core/style/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutGenerationContent extends StatefulWidget {
  const WorkoutGenerationContent({super.key});

  @override
  State<WorkoutGenerationContent> createState() =>
      _WorkoutGenerationContentState();
}

class _WorkoutGenerationContentState extends State<WorkoutGenerationContent> {
  @override
  void initState() {
    super.initState();
    // Check if user already has an active workout plan
    unawaited(context.read<WorkoutGenerationCubit>().checkActiveWorkoutPlan());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkoutGenerationCubit, WorkoutGenerationState>(
      listener: (context, state) {
        if (state is WorkoutGenerationSuccess) {
          // Refresh dashboard to show active plan
          // ignore: discarded_futures
          context.read<WorkoutDashboardCubit>().loadDashboard();
        }
      },
      builder: (context, state) {
        if (state is WorkoutGenerationInitial) {
          return _buildEmptyState(context);
        } else if (state is WorkoutGenerationInProgress) {
          return _buildProgressState(context, state);
        } else if (state is WorkoutGenerationSuccess) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WorkoutGenerationError) {
          return _buildErrorState(context, state);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: StyleConstants.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center,
              size: 64,
              color: KColors.primary.p500,
            ),
            KSizedBox.s20(),
            Center(
              child: const KText.headlineSmall(
                'No tienes un plan de entrenamiento',
                textAlign: TextAlign.center,
              ),
            ),
            KSizedBox.s10(),
            Center(
              child: const KText.bodyMedium(
                'Genera uno personalizado ahora.',
                textAlign: TextAlign.center,
              ),
            ),
            KSizedBox.s30(),
            CButton.primary(
              text: 'Generar Plan',
              onPressed: () async {
                await context
                    .read<WorkoutGenerationCubit>()
                    .generateWorkoutPlan(
                      weeks: 2,
                    );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressState(
    BuildContext context,
    WorkoutGenerationInProgress state,
  ) {
    return Padding(
      padding: StyleConstants.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          KSizedBox.s20(),
          const KText.titleMedium('Generando tu plan de entrenamiento...'),
          KSizedBox.s30(),
          // Animated tip display
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: Container(
              key: ValueKey(state.currentTip),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: KColors.primary.p200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: KColors.primary.p200,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: KColors.primary.p900,
                    size: 28,
                  ),
                  KSizedBox.s10(),
                  Expanded(
                    child: KText.bodyMedium(
                      state.currentTip,
                      color: KColors.primary.p900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WorkoutGenerationError state) {
    return Center(
      child: Padding(
        padding: StyleConstants.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            KText.bodyMedium('Error: ${state.message}'),
            KSizedBox.s10(),
            CButton.primary(
              text: 'Reintentar',
              onPressed: () async {
                await context
                    .read<WorkoutGenerationCubit>()
                    .generateWorkoutPlan(
                      weeks: 2,
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
