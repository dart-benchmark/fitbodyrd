import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/cubits/nutrition_dashboard_cubit.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/cubits/nutrition_dashboard_state.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/widgets/day_selector.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/widgets/edit_meal_food_dialog.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/widgets/food_search_dialog.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/widgets/meal_section.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/widgets/nutrition_summary_card.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:fitbodyrd_flutter/src/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NutritionDashboardContent extends StatelessWidget {
  const NutritionDashboardContent({
    required this.state,
    super.key,
  });

  final NutritionDashboardLoaded state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: DaySelector(
            selectedDate: state.selectedDate,
            startDate: state.activePlan?.startDate ?? DateTime.now(),
            onDateSelected: (date) async {
              await context.read<NutritionDashboardCubit>().selectDate(date);
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
            child: CustomScrollView(
              key: ValueKey(state.selectedDate.toString()),
              slivers: [
                SliverToBoxAdapter(
                  child: NutritionSummaryCard(
                    consumedCalories: state.consumedCalories,
                    targetCalories: state.targetCalories,
                    consumedProtein: state.consumedProtein,
                    targetProtein: state.targetProtein,
                    consumedCarbs: state.consumedCarbs,
                    targetCarbs: state.targetCarbs,
                    consumedFat: state.consumedFat,
                    targetFat: state.targetFat,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: _buildMealsList(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMealsList(BuildContext context) {
    if (state.meals.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: KText.bodyMedium('No hay comidas planificadas para este día.'),
        ),
      );
    }

    final sortedMeals = List<MealPlan>.from(state.meals)
      ..sort((a, b) => a.mealType.index.compareTo(b.mealType.index));

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final meal = sortedMeals[index];
          return MealSection(
            meal: meal,
            intakeLogs: state.intakeLogs,
            onFoodLogChanged: ({
              required MealPlanFood food,
              required bool isEaten,
            }) async {
              await context.read<NutritionDashboardCubit>().toggleFoodLog(
                    food: food,
                    isEaten: isEaten,
                  );
            },
            onFoodEdit: (food) async {
              final result = await showDialog<Map<String, num>>(
                context: context,
                builder: (context) => EditMealFoodDialog(mealPlanFood: food),
              );

              if (result != null && context.mounted) {
                final success = await context
                    .read<NutritionDashboardCubit>()
                    .updateMealPlanFood(
                      food: food,
                      servingQuantity: result['servingQuantity']!.toDouble(),
                      servingSizeId: result['servingSizeId']!.toInt(),
                      quantityGrams: result['quantityGrams']!.toDouble(),
                    );

                if (success != null && context.mounted) {
                  CoreUtils.showSnackBar(
                    context,
                    'Alimento actualizado correctamente',
                  );
                }
              }
            },
            onFoodDelete: (food) async {
              final success = await context
                  .read<NutritionDashboardCubit>()
                  .deleteMealPlanFood(
                    food: food,
                  );

              if (success && context.mounted) {
                CoreUtils.showSnackBar(
                  context,
                  'Alimento eliminado correctamente',
                );
              }
            },
            onAddFood: () async {
              // 1. Open search dialog
              final selectedFood = await showDialog<Food>(
                context: context,
                builder: (context) => const FoodSearchDialog(),
              );

              if (selectedFood == null || !context.mounted) return;

              // 2. Open edit dialog to configure portion
              final result = await showDialog<Map<String, num>>(
                context: context,
                builder: (context) => EditMealFoodDialog(food: selectedFood),
              );

              if (result == null || !context.mounted) return;

              // 3. Add to meal plan
              final success =
                  await context.read<NutritionDashboardCubit>().addFoodToMeal(
                        mealPlanId: meal.id!,
                        food: selectedFood,
                        servingQuantity: result['servingQuantity']!.toDouble(),
                        servingSizeId: result['servingSizeId']!.toInt(),
                        quantityGrams: result['quantityGrams']!.toDouble(),
                      );

              if (success && context.mounted) {
                CoreUtils.showSnackBar(
                  context,
                  'Alimento agregado correctamente',
                );
              } else if (!success && context.mounted) {
                CoreUtils.showSnackBar(
                  context,
                  'No se pudo agregar el alimento',
                );
              }
            },
          );
        },
        childCount: sortedMeals.length,
      ),
    );
  }
}
