import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.user, super.key});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: KColors.primary.p500,
              child: KText.headlineLarge(
                user.fullName.isNotEmpty ? user.fullName[0].toUpperCase() : 'U',
                color: Colors.white,
              ),
            ),
            KSizedBox.s15(),

            // Full Name
            KText.headlineMedium(user.fullName),
            KSizedBox.s5(),

            // Email
            KText.bodyMedium(
              user.email,
              color: KColors.greyScale.g600,
            ),
          ],
        ),
      ),
    );
  }
}
