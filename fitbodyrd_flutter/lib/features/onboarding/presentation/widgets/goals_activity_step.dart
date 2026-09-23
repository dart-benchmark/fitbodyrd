import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:fitbodyrd_flutter/src/core/extensions/enum_translations.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalsActivityStep extends StatelessWidget {
  const GoalsActivityStep({super.key});

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
              const KText.headlineMedium('Objetivos y Actividad'),
              KSizedBox.s25(),
              DropdownButtonFormField<BodyGoal>(
                initialValue: userProfile.bodyGoal,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Objetivo Corporal',
                  border: OutlineInputBorder(),
                ),
                items: BodyGoal.values.map((goal) {
                  return DropdownMenuItem(
                    value: goal,
                    child: KText.bodyMedium(goal.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    context.read<OnboardingCubit>().updateUserProfile(
                          userProfile.copyWith(bodyGoal: value),
                        );
                  }
                },
              ),
              KSizedBox.s15(),
              DropdownButtonFormField<ActivityLevel>(
                initialValue: userProfile.activityLevel,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Nivel de Actividad',
                  border: OutlineInputBorder(),
                ),
                items: ActivityLevel.values.map((level) {
                  return DropdownMenuItem(
                    value: level,
                    child: KText.bodyMedium(level.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    context.read<OnboardingCubit>().updateUserProfile(
                          userProfile.copyWith(activityLevel: value),
                        );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
