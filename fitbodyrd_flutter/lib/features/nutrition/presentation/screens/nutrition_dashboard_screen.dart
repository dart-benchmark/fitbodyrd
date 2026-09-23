import 'package:fitbodyrd_flutter/features/nutrition/presentation/cubits/nutrition_dashboard_cubit.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/cubits/nutrition_dashboard_state.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/cubits/nutrition_generation_cubit.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/widgets/nutrition_dashboard_content.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/widgets/nutrition_generation_content.dart';
import 'package:fitbodyrd_flutter/src/core/injections/injection_container.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NutritionDashboardScreen extends StatelessWidget {
  const NutritionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<NutritionDashboardCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<NutritionGenerationCubit>(),
        ),
      ],
      child: const NutritionDashboardView(),
    );
  }
}

class NutritionDashboardView extends StatelessWidget {
  const NutritionDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const KText.headlineSmall('Nutrición')),
      body: BlocBuilder<NutritionDashboardCubit, NutritionDashboardState>(
        builder: (context, dashboardState) {
          if (dashboardState is NutritionDashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (dashboardState is NutritionDashboardLoaded) {
            return NutritionDashboardContent(state: dashboardState);
          } else if (dashboardState is NutritionDashboardEmpty ||
              dashboardState is NutritionDashboardError) {
            return const NutritionGenerationContent();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
