import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/profile/presentation/widgets/info_row.dart';
import 'package:fitbodyrd_flutter/src/core/extensions/enum_translations.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';

class UserStatsSection extends StatelessWidget {
  const UserStatsSection({required this.user, super.key});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    final age = user.age ?? _calculateAge(user.birthDate);
    final heightCm = (user.heightMs * 100).toStringAsFixed(0);
    final weightKg = user.weightKgs.toStringAsFixed(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const KText.headlineSmall('Información Personal'),
        KSizedBox.s15(),
        Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InfoRow(
                  label: 'Edad',
                  value: '$age años',
                  icon: Icons.cake_outlined,
                ),
                const Divider(),
                InfoRow(
                  label: 'Sexo',
                  value: user.sex.displayName,
                  icon: Icons.person_outline,
                ),
                const Divider(),
                InfoRow(
                  label: 'Altura',
                  value: '$heightCm cm',
                  icon: Icons.height_outlined,
                ),
                const Divider(),
                InfoRow(
                  label: 'Peso',
                  value: '$weightKg kg',
                  icon: Icons.monitor_weight_outlined,
                ),
                if (user.bmi != null) ...[
                  const Divider(),
                  InfoRow(
                    label: 'IMC',
                    value: user.bmi!.toStringAsFixed(1),
                    icon: Icons.analytics_outlined,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  int _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    var age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
