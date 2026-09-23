import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditMealFoodDialog extends StatefulWidget {
  const EditMealFoodDialog({
    this.mealPlanFood,
    this.food,
    super.key,
  }) : assert(
          mealPlanFood != null || food != null,
          'mealPlanFood or food must be provided',
        );

  final MealPlanFood? mealPlanFood;
  final Food? food;

  @override
  State<EditMealFoodDialog> createState() => _EditMealFoodDialogState();
}

class _EditMealFoodDialogState extends State<EditMealFoodDialog> {
  late TextEditingController _servingQuantityController;
  late TextEditingController _manualGramsController;
  late FoodServingSize _selectedServingSize;
  bool _useManualGrams = false;
  String? _errorText;

  Food get _food => widget.mealPlanFood?.food ?? widget.food!;

  @override
  void initState() {
    super.initState();
    final initialServingSize =
        widget.mealPlanFood?.servingSize ?? _food.servingSizes!.first;
    _selectedServingSize = initialServingSize;

    final initialServingQuantity = widget.mealPlanFood?.servingQuantity ?? 1.0;
    final initialGrams =
        widget.mealPlanFood?.quantityGrams ?? initialServingSize.grams;

    _servingQuantityController = TextEditingController(
      text: initialServingQuantity.toStringAsFixed(
        initialServingQuantity.toInt() == initialServingQuantity ? 0 : 1,
      ),
    );
    _manualGramsController = TextEditingController(
      text: initialGrams.toStringAsFixed(0),
    );
  }

  @override
  void dispose() {
    _servingQuantityController.dispose();
    _manualGramsController.dispose();
    super.dispose();
  }

  double get _calculatedGrams {
    if (_useManualGrams) {
      return double.tryParse(_manualGramsController.text) ?? 0;
    }
    final servingQty = double.tryParse(_servingQuantityController.text) ?? 0;
    return servingQty * _selectedServingSize.grams;
  }

  Map<String, double> get _calculatedMacros {
    final foodData = _food;
    final multiplier = _calculatedGrams / 100;
    return {
      'calories': foodData.calories * multiplier,
      'protein': foodData.proteins * multiplier,
      'carbs': foodData.carbs * multiplier,
      'fat': foodData.fats * multiplier,
    };
  }

  bool _validate() {
    if (_useManualGrams) {
      final grams = double.tryParse(_manualGramsController.text);
      if (grams == null || grams <= 0) {
        setState(() {
          _errorText = 'Ingresa una cantidad válida en gramos';
        });
        return false;
      }
    } else {
      final servingQty = double.tryParse(_servingQuantityController.text);
      if (servingQty == null || servingQty <= 0) {
        setState(() {
          _errorText = 'Ingresa una cantidad válida de porciones';
        });
        return false;
      }
    }
    setState(() {
      _errorText = null;
    });
    return true;
  }

  void _save() {
    if (!_validate()) return;

    final servingQty = _useManualGrams
        ? _calculatedGrams / _selectedServingSize.grams
        : double.parse(_servingQuantityController.text);

    Navigator.of(context).pop(<String, num>{
      'servingQuantity': servingQty,
      'servingSizeId': _selectedServingSize.id!,
      'quantityGrams': _calculatedGrams,
    });
  }

  @override
  Widget build(BuildContext context) {
    final macros = _calculatedMacros;
    final servingSizes = _food.servingSizes ?? [];

    return AlertDialog(
      title: KText.titleMedium(
        widget.mealPlanFood != null ? 'Editar Alimento' : 'Agregar Alimento',
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KText.bodyLarge(
              _food.name,
              fontWeight: FontWeight.bold,
            ),
            KSizedBox.s20(),

            // Serving size selector
            if (servingSizes.isNotEmpty) ...[
              const KText.bodyMedium('Tamaño de porción'),
              KSizedBox.s10(),
              DropdownButtonFormField<int>(
                initialValue: _selectedServingSize.id,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                items: servingSizes.map((size) {
                  return DropdownMenuItem(
                    value: size.id,
                    child: KText.bodyMedium(
                      size.name,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedServingSize = servingSizes.firstWhere(
                        (size) => size.id == value,
                      );
                      _errorText = null;
                    });
                  }
                },
              ),
              KSizedBox.s20(),
            ],

            // Toggle between serving quantity and manual grams
            RadioGroup<bool>(
              groupValue: _useManualGrams,
              onChanged: (value) {
                setState(() {
                  _useManualGrams = value!;
                  _errorText = null;
                });
              },
              child: Row(
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const KText.bodySmall('Porciones'),
                      value: false,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const KText.bodySmall('Gramos'),
                      value: true,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  ),
                ],
              ),
            ),
            KSizedBox.s10(),

            // Input field
            if (_useManualGrams)
              TextField(
                controller: _manualGramsController,
                decoration: InputDecoration(
                  labelText: 'Cantidad (gramos)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorText: _errorText,
                  suffixText: 'g',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                onChanged: (_) {
                  setState(() {
                    _errorText = null;
                  });
                },
              )
            else
              TextField(
                controller: _servingQuantityController,
                decoration: InputDecoration(
                  labelText: 'Cantidad de porciones',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorText: _errorText,
                  helperText: 'Total: ${_calculatedGrams.toStringAsFixed(0)}g',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                onChanged: (_) {
                  setState(() {
                    _errorText = null;
                  });
                },
              ),
            KSizedBox.s20(),

            // Macro preview
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: KColors.greyScale.g900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const KText.bodyMedium(
                    'Vista Previa de Macros',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  KSizedBox.s10(),
                  _MacroRow(
                    label: 'Calorías',
                    value: macros['calories']!.toStringAsFixed(0),
                    unit: 'kcal',
                  ),
                  _MacroRow(
                    label: 'Proteínas',
                    value: macros['protein']!.toStringAsFixed(1),
                    unit: 'g',
                  ),
                  _MacroRow(
                    label: 'Carbohidratos',
                    value: macros['carbs']!.toStringAsFixed(1),
                    unit: 'g',
                  ),
                  _MacroRow(
                    label: 'Grasas',
                    value: macros['fat']!.toStringAsFixed(1),
                    unit: 'g',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const KText.bodyMedium('Cancelar'),
        ),
        FilledButton(
          onPressed: _save,
          child: const KText.bodyMedium('Guardar'),
        ),
      ],
    );
  }
}

class _MacroRow extends StatelessWidget {
  const _MacroRow({
    required this.label,
    required this.value,
    required this.unit,
  });

  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KText.bodySmall(label, color: Colors.white70),
          KText.bodySmall(
            '$value $unit',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
