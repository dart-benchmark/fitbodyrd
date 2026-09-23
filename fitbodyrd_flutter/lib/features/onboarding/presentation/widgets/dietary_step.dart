import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:fitbodyrd_flutter/src/core/extensions/enum_translations.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DietaryStep extends StatelessWidget {
  const DietaryStep({super.key});

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
              const KText.headlineMedium('Restricciones Dietéticas'),
              KSizedBox.s25(),
              DropdownButtonFormField<DietaryRestriction>(
                initialValue: userProfile.dietaryRestrictions,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Restricción Dietética',
                  border: OutlineInputBorder(),
                ),
                items: DietaryRestriction.values.map((restriction) {
                  return DropdownMenuItem(
                    value: restriction,
                    child: KText.bodyMedium(restriction.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    context.read<OnboardingCubit>().updateUserProfile(
                          userProfile.copyWith(dietaryRestrictions: value),
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
