import 'package:fitbodyrd_flutter/features/workouts/domain/repositories/workout_repository.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/workout_dashboard_cubit.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/cubits/workout_generation_cubit.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/widgets/active_workout_plan_content.dart';
import 'package:fitbodyrd_flutter/features/workouts/presentation/widgets/workout_generation_content.dart';
import 'package:fitbodyrd_flutter/src/core/injections/injection_container.dart';
import 'package:fitbodyrd_flutter/src/core/routing/app_routes.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WorkoutDashboardScreen extends StatelessWidget {
  const WorkoutDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<WorkoutDashboardCubit>(),
        ),
        BlocProvider(
          create: (context) => WorkoutGenerationCubit(
            repository: sl<WorkoutRepository>(),
          ),
        ),
      ],
      child: const WorkoutDashboardView(),
    );
  }
}

class WorkoutDashboardView extends StatelessWidget {
  const WorkoutDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const KText.headlineSmall('Entrenamientos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () async {
              await context.pushNamed(AppRoutes.workoutHistory.name);
            },
            tooltip: 'Ver historial',
          ),
        ],
      ),
      body: BlocBuilder<WorkoutDashboardCubit, WorkoutDashboardState>(
        builder: (context, state) {
          if (state is WorkoutDashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WorkoutDashboardLoaded) {
            return ActiveWorkoutPlanContent(state: state);
          } else if (state is WorkoutDashboardEmpty ||
              state is WorkoutDashboardError) {
            return const WorkoutGenerationContent();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
