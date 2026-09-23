import 'dart:async';

import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/nutrition/domain/repositories/nutrition_repository.dart';
import 'package:fitbodyrd_flutter/src/core/injections/injection_container.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:record_result/record_result.dart';

class FoodSearchDialog extends StatefulWidget {
  const FoodSearchDialog({super.key});

  @override
  State<FoodSearchDialog> createState() => _FoodSearchDialogState();
}

class _FoodSearchDialogState extends State<FoodSearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<Food> _searchResults = [];
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isNotEmpty) {
        await _performSearch(query);
      } else {
        setState(() {
          _searchResults = [];
          _error = null;
        });
      }
    });
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final repository = sl<NutritionRepository>();
    final result = await repository.searchFoods(query: query);

    if (mounted) {
      setState(() {
        _isLoading = false;
        if (result.isSuccess) {
          _searchResults = result.success!;
        } else {
          _error = result.failure?.message;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: KColors.greyScale.g900,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(
                  child: KText.titleMedium('Buscar Alimento'),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close, color: KColors.greyScale.g400),
                ),
              ],
            ),
            KSizedBox.s10(),
            TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Escribe el nombre del alimento...',
                hintStyle: TextStyle(color: KColors.greyScale.g500),
                prefixIcon: Icon(Icons.search, color: KColors.greyScale.g500),
                filled: true,
                fillColor: KColors.greyScale.g800,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            KSizedBox.s10(),
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: KText.bodyMedium(
          _error!,
          color: KColors.status.error,
          textAlign: TextAlign.center,
        ),
      );
    }

    if (_searchResults.isEmpty && _searchController.text.isNotEmpty) {
      return Center(
        child: KText.bodyMedium(
          'No se encontraron resultados',
          color: KColors.greyScale.g500,
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 48,
              color: KColors.greyScale.g700,
            ),
            KSizedBox.s10(),
            KText.bodyMedium(
              'Busca un alimento para agregarlo',
              color: KColors.greyScale.g500,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: _searchResults.length,
      separatorBuilder: (context, index) =>
          Divider(color: KColors.greyScale.g800, height: 1),
      itemBuilder: (context, index) {
        final food = _searchResults[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: KText.bodyMedium(food.name, fontWeight: FontWeight.bold),
          subtitle: KText.bodySmall(
            '${food.calories.toStringAsFixed(0)} kcal • '
            'P: ${food.proteins.toStringAsFixed(1)}g • C:'
            ' ${food.carbs.toStringAsFixed(1)}g • '
            'G:'
            ' ${food.fats.toStringAsFixed(1)}g',
            color: KColors.greyScale.g400,
          ),
          trailing: Icon(Icons.add_circle_outline, color: KColors.primary.p500),
          onTap: () => Navigator.of(context).pop(food),
        );
      },
    );
  }
}
