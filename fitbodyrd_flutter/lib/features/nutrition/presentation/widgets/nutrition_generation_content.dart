import 'dart:async';

import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/cubits/nutrition_dashboard_cubit.dart';
import 'package:fitbodyrd_flutter/features/nutrition/presentation/cubits/nutrition_generation_cubit.dart';
import 'package:fitbodyrd_flutter/src/core/common/components/c_button.dart';
import 'package:fitbodyrd_flutter/src/core/extensions/enum_translations.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:fitbodyrd_flutter/src/core/style/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NutritionGenerationContent extends StatefulWidget {
  const NutritionGenerationContent({super.key});

  @override
  State<NutritionGenerationContent> createState() =>
      _NutritionGenerationContentState();
}

class _NutritionGenerationContentState
    extends State<NutritionGenerationContent> {
  final List<MealPlanType> _selectedMealTypes = [
    MealPlanType.breakfast,
    MealPlanType.lunch,
    MealPlanType.dinner,
  ];

  Future<void> _generatePlan() async {
    if (_selectedMealTypes.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes seleccionar al menos 3 tipos de comida'),
        ),
      );
      return;
    }

    await context.read<NutritionGenerationCubit>().generateNutritionPlan(
          weeks: 1,
          mealTypes: _selectedMealTypes,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NutritionGenerationCubit, NutritionGenerationState>(
      listener: (context, state) {
        if (state is NutritionGenerationSuccess) {
          unawaited(context.read<NutritionDashboardCubit>().loadDashboard());
        }
      },
      builder: (context, state) {
        if (state is NutritionGenerationInitial) {
          return _buildEmptyState(context);
        } else if (state is NutritionGenerationInProgress) {
          return _buildProgressState(context, state);
        } else if (state is NutritionGenerationSuccess) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NutritionGenerationError) {
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
                    onPressed: _generatePlan,
                  ),
                ],
              ),
            ),
          );
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
            Icon(Icons.restaurant_menu, size: 64, color: KColors.primary.p500),
            KSizedBox.s20(),
            const KText.headlineSmall('No tienes un plan nutricional'),
            KSizedBox.s10(),
            const KText.bodyMedium('Genera uno personalizado ahora.'),
            KSizedBox.s30(),
            const KText.titleMedium('Selecciona tus comidas:'),
            KSizedBox.s10(),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: MealPlanType.values.map((type) {
                final isSelected = _selectedMealTypes.contains(type);
                return FilterChip(
                  label: KText.bodyMedium(type.displayName),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedMealTypes.add(type);
                      } else {
                        _selectedMealTypes.remove(type);
                      }
                    });
                  },
                  selectedColor: KColors.primary.p200,
                  checkmarkColor: KColors.primary.p900,
                );
              }).toList(),
            ),
            KSizedBox.s30(),
            CButton.primary(
              text: 'Generar Plan',
              onPressed: _generatePlan,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressState(
    BuildContext context,
    NutritionGenerationInProgress state,
  ) {
    return Padding(
      padding: StyleConstants.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          KSizedBox.s20(),
          KText.titleMedium(state.message),
          KSizedBox.s10(),
          LinearProgressIndicator(
            value: state.progress,
            color: KColors.primary.p500,
            backgroundColor: KColors.greyScale.g300,
          ),
          KSizedBox.s10(),
          KText.bodySmall('${(state.progress * 100).toStringAsFixed(0)}%'),
          if (state.partialPlan != null) ...[
            KSizedBox.s30(),
            const Divider(),
            KSizedBox.s10(),
            const KText.titleMedium('Vista Previa del Plan'),
            Expanded(
              child: ListView.builder(
                itemCount: state.partialPlan!.mealPlans?.length ?? 0,
                itemBuilder: (context, index) {
                  final meal = state.partialPlan!.mealPlans![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KText.bodyMedium(
                            'Día ${meal.dayNumber} - '
                            '${meal.mealType.displayName}',
                            fontWeight: FontWeight.bold,
                          ),
                          if (meal.mealPlanFoods != null &&
                              meal.mealPlanFoods!.isNotEmpty) ...[
                            KSizedBox.s10(),
                            ...meal.mealPlanFoods!.map(
                              (f) => Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                  bottom: 4.0,
                                ),
                                child: KText.bodySmall(
                                  '- ${f.food?.name ?? "Desconocido"}'
                                  ' (${f.quantityGrams.toStringAsFixed(0)}g)',
                                ),
                              ),
                            ),
                          ] else
                            const Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: KText.bodySmall('Sin alimentos asignados'),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
