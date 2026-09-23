import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:fitbodyrd_flutter/src/core/extensions/enum_translations.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisePreferencesStep extends StatelessWidget {
  const ExercisePreferencesStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final userProfile = state.userProfile;
        if (userProfile == null) return const SizedBox.shrink();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const KText.headlineMedium('Preferencias de Ejercicio'),
              KSizedBox.s25(),
              KText.titleMedium(
                'Días por semana: ${userProfile.daysPerWeekExercise}',
              ),
              Slider(
                value: userProfile.daysPerWeekExercise.toDouble(),
                min: 1,
                max: 7,
                divisions: 6,
                label: userProfile.daysPerWeekExercise.toString(),
                onChanged: (value) {
                  context.read<OnboardingCubit>().updateUserProfile(
                        userProfile.copyWith(
                          daysPerWeekExercise: value.round(),
                        ),
                      );
                },
              ),
              KSizedBox.s15(),
              KText.titleMedium(
                'Minutos por sesión:'
                ' ${userProfile.timePerExerciseSessionMinutes}',
              ),
              Slider(
                value: userProfile.timePerExerciseSessionMinutes.toDouble(),
                min: 15,
                max: 120,
                divisions: 7,
                label: userProfile.timePerExerciseSessionMinutes.toString(),
                onChanged: (value) {
                  context.read<OnboardingCubit>().updateUserProfile(
                        userProfile.copyWith(
                          timePerExerciseSessionMinutes: value.round(),
                        ),
                      );
                },
              ),
              KSizedBox.s15(),
              DropdownButtonFormField<ExerciseDifficulty>(
                initialValue: userProfile.experienceLevel,
                decoration: const InputDecoration(
                  labelText: 'Nivel de Experiencia',
                  border: OutlineInputBorder(),
                ),
                items: ExerciseDifficulty.values.map((level) {
                  return DropdownMenuItem(
                    value: level,
                    child: KText.bodyMedium(level.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    context.read<OnboardingCubit>().updateUserProfile(
                          userProfile.copyWith(experienceLevel: value),
                        );
                  }
                },
              ),
              KSizedBox.s15(),
              SwitchListTile(
                title: const KText.bodyMedium('Tengo acceso a equipo'),
                value: userProfile.hasEquipment,
                onChanged: (value) {
                  context.read<OnboardingCubit>().updateUserProfile(
                        userProfile.copyWith(hasEquipment: value),
                      );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
