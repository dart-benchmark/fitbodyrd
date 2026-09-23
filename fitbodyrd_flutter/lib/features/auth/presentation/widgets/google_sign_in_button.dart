import 'package:fitbodyrd_flutter/src/core/common/components/c_button.dart';
import 'package:fitbodyrd_flutter/src/core/gen/assets.gen.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CGoogleSignInButton extends StatelessWidget {
  const CGoogleSignInButton({
    super.key,
    this.onPressed,
  });
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CButton(
      widget: Assets.icons.google.svg(
        height: 32.h,
        width: 32.h,
      ),
      padding: EdgeInsets.symmetric(vertical: 4.h),
      onPressed: onPressed,
      backgroundColor: KColors.greyScale.g100,
      textColor: KColors.greyScale.g1000,
    );
  }
}
