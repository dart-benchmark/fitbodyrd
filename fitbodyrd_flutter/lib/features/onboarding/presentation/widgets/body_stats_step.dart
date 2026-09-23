import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:fitbodyrd_flutter/src/core/common/components/c_text_field.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyStatsStep extends StatefulWidget {
  const BodyStatsStep({
    required this.formKey,
    super.key,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<BodyStatsStep> createState() => _BodyStatsStepState();
}

class _BodyStatsStepState extends State<BodyStatsStep> {
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    final userProfile = context.read<OnboardingCubit>().state.userProfile;
    _heightController = TextEditingController(
      text: userProfile?.heightMs == 0 ? '' : userProfile?.heightMs.toString(),
    );
    _weightController = TextEditingController(
      text:
          userProfile?.weightKgs == 0 ? '' : userProfile?.weightKgs.toString(),
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final userProfile = state.userProfile;
        if (userProfile == null) return const SizedBox.shrink();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const KText.headlineMedium('Estadísticas Corporales'),
                KSizedBox.s25(),
                CTextField(
                  controller: _heightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  placeholderText: 'Altura (Metros)',
                  trailingIcon: const KText.bodyMedium('m'),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  onChanged: (value) {
                    final height = double.tryParse(value);
                    if (height != null) {
                      context.read<OnboardingCubit>().updateUserProfile(
                            userProfile.copyWith(heightMs: height),
                          );
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su altura';
                    }
                    final height = double.tryParse(value);
                    if (height == null || height <= 0) {
                      return 'Por favor ingrese una altura válida';
                    }
                    return null;
                  },
                ),
                KSizedBox.s15(),
                CTextField(
                  controller: _weightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  placeholderText: 'Peso (Kilogramos)',
                  trailingIcon: const KText.bodyMedium('kg'),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  onChanged: (value) {
                    final weight = double.tryParse(value);
                    if (weight != null) {
                      context.read<OnboardingCubit>().updateUserProfile(
                            userProfile.copyWith(weightKgs: weight),
                          );
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su peso';
                    }
                    final weight = double.tryParse(value);
                    if (weight == null || weight <= 0) {
                      return 'Por favor ingrese un peso válido';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
