import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KSizedBox extends StatelessWidget {
  const KSizedBox({required this.size, super.key});

  KSizedBox.s2({super.key}) : size = 2.h;
  KSizedBox.s5({super.key}) : size = 5.h;
  KSizedBox.s10({super.key}) : size = 10.h;
  KSizedBox.s15({super.key}) : size = 15.h;
  KSizedBox.s20({super.key}) : size = 20.h;
  KSizedBox.s25({super.key}) : size = 25.h;
  KSizedBox.s30({super.key}) : size = 30.h;

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size);
  }
}
