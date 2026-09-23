import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/widgets/meal_section.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';

class MealListView extends StatelessWidget {
  const MealListView({
    required this.meals,
    required this.intakeLogs,
    required this.onFoodLogChanged,
    required this.onFoodEdit,
    required this.onFoodDelete,
    required this.onAddFood,
    super.key,
  });
  final List<MealPlan> meals;
  final List<FoodIntakeLog> intakeLogs;
  final void Function({
    required MealPlanFood food,
    required bool isEaten,
  }) onFoodLogChanged;
  final void Function(MealPlanFood food) onFoodEdit;
  final void Function(MealPlanFood food) onFoodDelete;
  final void Function(MealPlan meal) onAddFood;

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return const Center(
        child: KText.bodyMedium('No hay comidas planificadas para este día.'),
      );
    }

    // Group meals by type if needed, but usually MealPlan is one per
    // type per day?
    // DB design: MealPlan has meal_type. So multiple MealPlan rows per day.

    // Sort by meal type order (assuming enum order is correct or we map it)
    final sortedMeals = List<MealPlan>.from(meals)
      ..sort((a, b) => a.mealType.index.compareTo(b.mealType.index));

    return ListView.builder(
      itemCount: sortedMeals.length,
      itemBuilder: (context, index) {
        final meal = sortedMeals[index];
        return MealSection(
          meal: meal,
          intakeLogs: intakeLogs,
          onFoodLogChanged: onFoodLogChanged,
          onFoodEdit: onFoodEdit,
          onFoodDelete: onFoodDelete,
          onAddFood: () => onAddFood(meal),
        );
      },
    );
  }
}
