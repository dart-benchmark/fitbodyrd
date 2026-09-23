import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';

class MealFoodItem extends StatelessWidget {
  const MealFoodItem({
    required this.food,
    required this.isEaten,
    required this.onEatenChanged,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });
  final MealPlanFood food;
  final bool isEaten;
  final ValueChanged<bool?> onEatenChanged;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final foodData = food.food;
    final multiplier = food.quantityGrams / 100;
    final calories = foodData != null
        ? (foodData.calories * multiplier).toStringAsFixed(0)
        : '0';
    final protein = foodData != null
        ? (foodData.proteins * multiplier).toStringAsFixed(1)
        : '0';
    final carbs = foodData != null
        ? (foodData.carbs * multiplier).toStringAsFixed(1)
        : '0';
    final fat = foodData != null
        ? (foodData.fats * multiplier).toStringAsFixed(1)
        : '0';

    return Dismissible(
      key: Key('meal_food_${food.id}'),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const KText.titleMedium('Eliminar Alimento'),
            content: KText.bodyMedium(
              '¿Estás seguro de que deseas eliminar'
              ' "${food.food?.name ?? 'este alimento'}"'
              ' de tu plan?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const KText.bodyMedium('Cancelar'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const KText.bodyMedium('Eliminar'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 28,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        elevation: 0,
        color: KColors.greyScale.g900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: isEaten ? KColors.primary.p500 : KColors.greyScale.g300,
            width: isEaten ? 2 : 1,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          leading: Checkbox(
            value: isEaten,
            onChanged: onEatenChanged,
            activeColor: KColors.primary.p500,
            fillColor: isEaten
                ? WidgetStatePropertyAll(KColors.primary.p500)
                : WidgetStatePropertyAll(KColors.greyScale.g500),
            checkColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText.bodyMedium(
                food.food?.name ?? 'Alimento desconocido',
                decoration: isEaten ? TextDecoration.lineThrough : null,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              KText.bodySmall(
                '$calories kcal • P: ${protein}g • C: ${carbs}g • G: ${fat}g',
                color: Colors.white,
              ),
            ],
          ),
          subtitle: KText.bodySmall(
            '${food.quantityGrams.toStringAsFixed(0)}g',
            color: Colors.white,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (food.food?.imageUrl != null &&
                  food.food!.imageUrl!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      food.food!.imageUrl!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const SizedBox(width: 40),
                    ),
                  ),
                ),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20,
                  color: KColors.primary.p500,
                ),
                onPressed: onEdit,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
