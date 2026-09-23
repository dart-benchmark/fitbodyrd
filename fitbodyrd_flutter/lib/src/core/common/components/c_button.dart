import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CButton extends StatelessWidget {
  const CButton({
    required this.widget,
    super.key,
    this.backgroundColor,
    this.onPressed,
    this.textColor,
    this.width,
    this.padding,
  });

  CButton.primary({
    required String text,
    super.key,
    this.onPressed,
    this.width = double.infinity,
    this.padding,
  })  : backgroundColor = KColors.primary.p500,
        textColor = KColors.greyScale.g1000,
        widget = KText.bodyMedium(text);

  final Widget widget;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? KColors.primary.p500,
          foregroundColor: textColor ?? KColors.greyScale.g100,
          padding: padding ??
              EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 16.w,
              ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        onPressed: onPressed,
        child: widget,
      ),
    );
  }
}
