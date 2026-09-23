import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KText extends StatelessWidget {
  const KText({
    required this.text,
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.decoration,
  });

  /// Bold/32px
  const KText.headlineLarge(
    this.text, {
    super.key,
    this.fontSize = 32,
    this.fontWeight = FontWeight.w700,
    this.color,
    this.textAlign,
    this.decoration,
  });

  /// SemiBold/24px
  const KText.headlineMedium(
    this.text, {
    super.key,
    this.fontSize = 24,
    this.fontWeight = FontWeight.w600,
    this.color,
    this.textAlign,
    this.decoration,
  });

  /// Medium/22px
  const KText.headlineSmall(
    this.text, {
    super.key,
    this.fontSize = 22,
    this.fontWeight = FontWeight.w500,
    this.color,
    this.textAlign,
    this.decoration,
  });

  /// SemiBold/18px
  const KText.titleLarge(
    this.text, {
    super.key,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w600,
    this.color,
    this.textAlign,
    this.decoration,
  });

  /// SemiBold/16px
  const KText.titleMedium(
    this.text, {
    super.key,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.color,
    this.textAlign,
    this.decoration,
  });

  /// SemiBold/14px
  const KText.titleSmall(
    this.text, {
    super.key,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.color,
    this.textAlign,
    this.decoration,
  });

  /// SemiBold/14px
  const KText.labelLarge(
    this.text, {
    super.key,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.color,
    this.textAlign,
    this.decoration,
  });

  /// Regular/12px
  const KText.labelMedium(
    this.text, {
    super.key,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.textAlign,
    this.decoration,
  });

  /// Regular/11px
  const KText.labelSmall(
    this.text, {
    super.key,
    this.fontSize = 11,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.textAlign,
    this.decoration,
  });

  /// Regular/16px
  const KText.bodyLarge(
    this.text, {
    super.key,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.textAlign,
    this.decoration,
  });

  /// Regular/14px
  const KText.bodyMedium(
    this.text, {
    super.key,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.textAlign,
    this.decoration,
  });

  /// Regular/12px
  const KText.bodySmall(
    this.text, {
    super.key,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.textAlign,
    this.decoration,
  });

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
      ),
    );
  }
}
