import 'package:fitbodyrd_flutter/src/core/common/components/c_button.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';

class SessionCompletedDialog extends StatelessWidget {
  const SessionCompletedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: KColors.greyScale.g900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.celebration,
              size: 64,
              color: KColors.primary.p500,
            ),
            KSizedBox.s20(),
            KText.headlineSmall(
              '¡Sigue así!',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            KSizedBox.s10(),
            KText.bodyMedium(
              'Has completado todos los ejercicios de esta sesión.',
              color: KColors.greyScale.g200,
              textAlign: TextAlign.center,
            ),
            KSizedBox.s20(),
            CButton.primary(
              text: '¡Genial!',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
