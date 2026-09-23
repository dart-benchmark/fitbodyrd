import 'package:fitbodyrd_flutter/src/core/extensions/buildcontext_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CTextField extends StatelessWidget {
  const CTextField({
    super.key,
    this.placeholderText,
    this.leadingIcon,
    this.trailingIcon,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.obscureText = false,
    this.validator,
    this.onTapOutside,
    this.focusNode,
    this.inputFormatters,
    this.labelText,
  });

  final String? placeholderText;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(PointerDownEvent)? onTapOutside;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final String? labelText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 2.h),
      decoration: BoxDecoration(
        color: context.theme.inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          if (leadingIcon != null)
            Padding(
              padding: EdgeInsets.only(right: 4.h),
              child: leadingIcon,
            ),
          Expanded(
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              onTapOutside: onTapOutside,
              onChanged: onChanged,
              validator: validator,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              onFieldSubmitted: (value) {
                // forward callback if user wants it
                onSubmitted?.call(value);

                // handle "next"
                if (textInputAction == TextInputAction.next &&
                    trailingIcon != null) {
                  FocusScope.of(context).nextFocus();
                }
              },
              textInputAction: textInputAction,
              obscureText: obscureText,
              decoration: InputDecoration(
                labelText: labelText,
                contentPadding: EdgeInsets.zero,
                fillColor: Colors.transparent,
                hintText: placeholderText,
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintStyle: GoogleFonts.poppins(
                  color: context.theme.hintColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          if (trailingIcon != null)
            Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: trailingIcon,
            ),
        ],
      ),
    );
  }
}
