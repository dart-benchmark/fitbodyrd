import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:fitbodyrd_flutter/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:fitbodyrd_flutter/src/core/common/components/c_text_field.dart';
import 'package:fitbodyrd_flutter/src/core/extensions/enum_translations.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PersonalInfoStep extends StatefulWidget {
  const PersonalInfoStep({
    required this.formKey,
    super.key,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep> {
  late final TextEditingController _nameController;
  late final TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    final userProfile = context.read<OnboardingCubit>().state.userProfile;
    _nameController = TextEditingController(text: userProfile?.fullName);
    _dobController = TextEditingController(
      text: userProfile != null
          ? DateFormat.yMMMd('es').format(userProfile.birthDate)
          : '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) =>
          previous.userProfile?.birthDate != current.userProfile?.birthDate,
      listener: (context, state) {
        if (state.userProfile != null) {
          _dobController.text =
              DateFormat.yMMMd('es').format(state.userProfile!.birthDate);
        }
      },
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
                const KText.headlineMedium('Información Personal'),
                KSizedBox.s25(),
                CTextField(
                  controller: _nameController,
                  placeholderText: 'Nombre Completo',
                  onChanged: (value) {
                    context.read<OnboardingCubit>().updateUserProfile(
                          userProfile.copyWith(fullName: value),
                        );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su nombre completo';
                    }
                    return null;
                  },
                ),
                KSizedBox.s15(),
                GestureDetector(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: userProfile.birthDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (date != null && context.mounted) {
                      context.read<OnboardingCubit>().updateUserProfile(
                            userProfile.copyWith(birthDate: date),
                          );
                    }
                  },
                  child: AbsorbPointer(
                    child: CTextField(
                      controller: _dobController,
                      placeholderText: 'Fecha de Nacimiento',
                      trailingIcon: const Icon(Icons.calendar_today),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor seleccione su fecha de nacimiento';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                KSizedBox.s15(),
                DropdownButtonFormField<Sex>(
                  initialValue: userProfile.sex,
                  decoration: const InputDecoration(
                    labelText: 'Sexo',
                    border: OutlineInputBorder(),
                  ),
                  items: Sex.values.map((sex) {
                    return DropdownMenuItem(
                      value: sex,
                      child: KText.bodyMedium(sex.displayName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      context.read<OnboardingCubit>().updateUserProfile(
                            userProfile.copyWith(sex: value),
                          );
                    }
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
