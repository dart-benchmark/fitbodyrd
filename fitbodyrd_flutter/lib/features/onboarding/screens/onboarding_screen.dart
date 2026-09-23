import 'dart:async';

import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/widgets/body_stats_step.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/widgets/dietary_step.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/widgets/exercise_preferences_step.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/widgets/goals_activity_step.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/widgets/personal_info_step.dart';
import 'package:fitbodyrd_flutter/src/core/common/components/c_button.dart';
import 'package:fitbodyrd_flutter/src/core/routing/app_routes.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(), // Personal Info
    GlobalKey<FormState>(), // Body Stats
    GlobalKey<FormState>(), // Goals & Activity (No form validation needed yet)
    GlobalKey<
        FormState>(), // Exercise Preferences (No form validation needed yet)
    GlobalKey<
        FormState>(), // Dietary Restrictions (No form validation needed yet)
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) =>
          previous.currentStep != current.currentStep ||
          previous.status != current.status,
      listener: (context, state) {
        if (state.status == OnboardingStatus.success) {
          context.goNamed(AppRoutes.home.name);
        } else if (state.status == OnboardingStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  KText.bodyMedium(state.errorMessage ?? 'Ocurrió un error'),
            ),
          );
        } else {
          unawaited(
            _pageController.animateToPage(
              state.currentStep,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          );
        }
      },
      builder: (context, state) {
        final steps = [
          PersonalInfoStep(formKey: _formKeys[0]),
          BodyStatsStep(formKey: _formKeys[1]),
          const GoalsActivityStep(),
          const ExercisePreferencesStep(),
          const DietaryStep(),
        ];

        final progress = (state.currentStep) / steps.length;

        return Scaffold(
          appBar: AppBar(
            title: const KText.titleLarge('Bienvenida'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          body: state.status == OnboardingStatus.submitting
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: steps,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (state.currentStep > 0)
                            CButton.primary(
                              onPressed: () {
                                context.read<OnboardingCubit>().previousPage();
                              },
                              width: null,
                              text: 'Atrás',
                            )
                          else
                            const SizedBox.shrink(),
                          CButton.primary(
                            onPressed: () async {
                              final currentFormKey =
                                  _formKeys[state.currentStep];
                              if (currentFormKey.currentState != null &&
                                  !currentFormKey.currentState!.validate()) {
                                return;
                              }

                              if (state.currentStep < steps.length - 1) {
                                context.read<OnboardingCubit>().nextPage();
                              } else {
                                await context.read<OnboardingCubit>().submit();
                              }
                            },
                            width: null,
                            text: state.currentStep == steps.length - 1
                                ? 'Finalizar'
                                : 'Siguiente',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
