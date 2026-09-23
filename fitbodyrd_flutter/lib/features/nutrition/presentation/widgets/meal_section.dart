import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/widgets/meal_food_item.dart';
import 'package:fitbodyrd_flutter/src/core/extensions/enum_translations.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';

class MealSection extends StatelessWidget {
  const MealSection({
    required this.meal,
    required this.intakeLogs,
    required this.onFoodLogChanged,
    required this.onFoodEdit,
    required this.onFoodDelete,
    required this.onAddFood,
    super.key,
  });

  final MealPlan meal;
  final List<FoodIntakeLog> intakeLogs;
  final void Function({
    required MealPlanFood food,
    required bool isEaten,
  }) onFoodLogChanged;
  final void Function(MealPlanFood food) onFoodEdit;
  final void Function(MealPlanFood food) onFoodDelete;
  final VoidCallback onAddFood;

  @override
  Widget build(BuildContext context) {
    // Calculate consumed macros for this meal type
    final consumedLogs =
        intakeLogs.where((log) => log.mealPlanId == meal.id).toList();
    double consumedCalories = 0;
    double consumedProtein = 0;
    double consumedCarbs = 0;
    double consumedFat = 0;

    for (final log in consumedLogs) {
      final food = log.food;
      if (food != null) {
        final multiplier = log.quantityGrams / 100;
        consumedCalories += food.calories * multiplier;
        consumedProtein += food.proteins * multiplier;
        consumedCarbs += food.carbs * multiplier;
        consumedFat += food.fats * multiplier;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: KColors.primary.p500,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  KText.titleMedium(
                    meal.mealType.displayName,
                    fontWeight: FontWeight.bold,
                  ),
                  const Spacer(),
                  KText.bodySmall(
                    '${consumedCalories.toStringAsFixed(0)} / ${meal.targetCalories.toStringAsFixed(0)} kcal',
                    color: KColors.greyScale.g500,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  children: [
                    _MacroText(
                      label: 'P',
                      consumed: consumedProtein,
                      target: meal.targetProteins,
                    ),
                    const SizedBox(width: 16),
                    _MacroText(
                      label: 'C',
                      consumed: consumedCarbs,
                      target: meal.targetCarbs,
                    ),
                    const SizedBox(width: 16),
                    _MacroText(
                      label: 'G',
                      consumed: consumedFat,
                      target: meal.targetFats,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (meal.mealPlanFoods != null)
          ...meal.mealPlanFoods!.map((food) {
            final isEaten = intakeLogs.any(
              (log) => log.mealPlanId == meal.id && log.foodId == food.foodId,
            );

            return MealFoodItem(
              food: food,
              isEaten: isEaten,
              onEatenChanged: (value) {
                if (value != null) {
                  onFoodLogChanged(
                    food: food,
                    isEaten: value,
                  );
                }
              },
              onEdit: () => onFoodEdit(food),
              onDelete: () => onFoodDelete(food),
            );
          }),
        KSizedBox.s20(),
        Center(
          child: TextButton.icon(
            onPressed: onAddFood,
            icon: Icon(Icons.add, color: KColors.primary.p500),
            label: KText.bodyMedium(
              'Agregar Alimento',
              color: KColors.primary.p500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        KSizedBox.s20(),
      ],
    );
  }
}

class _MacroText extends StatelessWidget {
  const _MacroText({
    required this.label,
    required this.consumed,
    required this.target,
  });

  final String label;
  final double consumed;
  final double target;

  @override
  Widget build(BuildContext context) {
    return KText.bodySmall(
      '$label: ${consumed.toStringAsFixed(0)}/${target.toStringAsFixed(0)}g',
      color: KColors.greyScale.g600,
    );
  }
}
