import 'package:fitbodyrd_flutter/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:fitbodyrd_flutter/features/home/presentation/cubits/home_dashboard_cubit.dart';
import 'package:fitbodyrd_flutter/features/home/presentation/cubits/home_dashboard_state.dart';
import 'package:fitbodyrd_flutter/features/home/presentation/widgets/greeting_header.dart';
import 'package:fitbodyrd_flutter/features/home/presentation/widgets/quick_actions_card.dart';
import 'package:fitbodyrd_flutter/features/home/presentation/widgets/todays_progress_card.dart';
import 'package:fitbodyrd_flutter/features/home/presentation/widgets/weekly_summary_card.dart';
import 'package:fitbodyrd_flutter/src/core/injections/injection_container.dart';
import 'package:fitbodyrd_flutter/src/core/services/tab_preload_service.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<HomeDashboardCubit>(),
        ),
      ],
      child: const HomeDashboardView(),
    );
  }
}

class HomeDashboardView extends StatelessWidget {
  const HomeDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const KText.headlineSmall('Inicio'),
      ),
      body: BlocBuilder<HomeDashboardCubit, HomeDashboardState>(
        buildWhen: (previous, current) {
          if (current is HomeDashboardLoaded &&
              previous is! HomeDashboardLoaded) {
            TabPreloadService.preloadTabs().ignore();
          }
          return current != previous;
        },
        builder: (context, state) {
          if (state is HomeDashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeDashboardLoaded) {
            return BlocBuilder<UserCubit, UserState>(
              builder: (context, userState) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (userState is UserLoaded)
                        GreetingHeader(user: userState.user),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TodaysProgressCard(
                          nutritionPlan: state.nutritionPlan,
                          workoutPlan: state.workoutPlan,
                          todayCalories: state.todayCalories,
                          targetCalories: state.targetCalories,
                          hasWorkoutToday: state.hasWorkoutToday,
                          isWorkoutCompleted: state.isWorkoutCompleted,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: WeeklySummaryCard(summary: state.summary),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const QuickActionsCard(),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is HomeDashboardError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KText.bodyLarge(
                    'Error al cargar el dashboard',
                    color: Colors.red,
                  ),
                  const SizedBox(height: 8),
                  KText.bodyMedium(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await context.read<HomeDashboardCubit>().loadDashboard();
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
