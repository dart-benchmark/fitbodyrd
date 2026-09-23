import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/nutrition/domain/repositories/nutrition_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_result/record_result.dart';

part 'nutrition_generation_state.dart';

class NutritionGenerationCubit extends Cubit<NutritionGenerationState> {
  NutritionGenerationCubit({
    required NutritionRepository nutritionRepository,
  })  : _nutritionRepository = nutritionRepository,
        super(const NutritionGenerationInitial());

  final NutritionRepository _nutritionRepository;
  StreamSubscription<GenerateNutritionPlanProgressDto>? _generationSubscription;

  Future<void> generateNutritionPlan({
    required int weeks,
    required List<MealPlanType> mealTypes,
  }) async {
    emit(
      const NutritionGenerationInProgress(
        message: 'Iniciando generación...',
        progress: 0,
      ),
    );

    try {
      final stream = _nutritionRepository.requestNutritionPlanGeneration(
        weeks: weeks,
        mealTypes: mealTypes,
      );

      await _generationSubscription?.cancel();
      _generationSubscription = stream.listen(
        (progressDto) async {
          if (progressDto.status == StreamStatus.error) {
            emit(NutritionGenerationError(progressDto.message));
            return;
          }

          if (progressDto.status == StreamStatus.completed) {
            final result = await _nutritionRepository.getActiveNutritionPlan();
            if (result.isSuccess) {
              emit(NutritionGenerationSuccess(result.success!));
            } else {
              emit(
                NutritionGenerationError(
                  result.failure?.message ?? 'Unknown error',
                ),
              );
            }
            return;
          }

          // Fetch partial plan to show progress
          NutritionPlan? partialPlan;
          final result = await _nutritionRepository.getActiveNutritionPlan();
          if (result.isSuccess) {
            partialPlan = result.success;
          }

          emit(
            NutritionGenerationInProgress(
              message: progressDto.message,
              progress: progressDto.progressPercentage / 100,
              partialPlan: partialPlan,
            ),
          );
        },
        onError: (Object error) {
          emit(NutritionGenerationError(error.toString()));
        },
      );
    } on AppException catch (e) {
      emit(NutritionGenerationError(e.message));
    }
  }

  Future<void> checkActivePlan() async {
    final result = await _nutritionRepository.getActiveNutritionPlan();
    if (result.isSuccess) {
      emit(NutritionGenerationSuccess(result.success!));
    }
    // If failure, we just stay in initial state or whatever state we are in
  }

  @override
  Future<void> close() async {
    await _generationSubscription?.cancel();
    return super.close();
  }
}
