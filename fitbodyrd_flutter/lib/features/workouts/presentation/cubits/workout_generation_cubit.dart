import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/workouts/domain/repositories/workout_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_result/record_result.dart';

part 'workout_generation_state.dart';

class WorkoutGenerationCubit extends Cubit<WorkoutGenerationState> {
  WorkoutGenerationCubit({required WorkoutRepository repository})
      : _repository = repository,
        super(const WorkoutGenerationInitial());
  final WorkoutRepository _repository;
  StreamSubscription<GenerateWorkoutPlanProgressDto>? _generationSubscription;
  StreamSubscription<String>? _tipsSubscription;

  Future<void> generateWorkoutPlan({required int weeks}) async {
    emit(
      const WorkoutGenerationInProgress(
        currentTip: 'Iniciando generación...',
      ),
    );

    // Start listening to tips stream
    _startListeningToTips();

    // Listen to generation stream
    final stream = _repository.requestWorkoutPlanGeneration(
      numberOfWeeks: weeks,
    );

    _generationSubscription = stream.listen(
      (status) async {
        if (status.status == StreamStatus.completed) {
          await _stopListeningToTips();
          final result = await _repository.getActiveWorkoutPlan();
          if (result.isSuccess) {
            emit(WorkoutGenerationSuccess(result.success!));
          } else {
            emit(
              WorkoutGenerationError(
                result.failure?.message ?? 'Unknown error',
              ),
            );
          }
        } else if (status.status == StreamStatus.error) {
          await _stopListeningToTips();
          emit(const WorkoutGenerationError('Error generating workout plan'));
        }
      },
      onError: (Object error) async {
        await _stopListeningToTips();
        emit(WorkoutGenerationError(error.toString()));
      },
    );
  }

  Future<void> checkActiveWorkoutPlan() async {
    final result = await _repository.getActiveWorkoutPlan();
    if (result.isSuccess) {
      emit(WorkoutGenerationSuccess(result.success!));
    } else {
      // If error code is 7001 (no active plan), stay in initial state
      // Otherwise, it's a different error
      if (result.failure?.statusCode == 7001) {
        // Stay in initial state - no active plan exists
        return;
      }
      // For other errors, emit error state
      emit(
        WorkoutGenerationError(
          result.failure?.message ?? 'Unknown error',
        ),
      );
    }
  }

  void _startListeningToTips() {
    _tipsSubscription = _repository.listenToWorkoutTips().listen(
      (tip) {
        if (state is WorkoutGenerationInProgress) {
          emit(WorkoutGenerationInProgress(currentTip: tip));
        }
      },
      onError: (Object error) {
        // Log error but don't stop generation
        debugPrint('Error receiving tip: $error');
      },
    );
  }

  Future<void> _stopListeningToTips() async {
    await _tipsSubscription?.cancel();
    _tipsSubscription = null;
  }

  @override
  Future<void> close() async {
    await _stopListeningToTips();
    await _generationSubscription?.cancel();
    return super.close();
  }
}
