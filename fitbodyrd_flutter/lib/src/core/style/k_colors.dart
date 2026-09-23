// To create abstract subclasses without having a public constructor
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

abstract class KColors {
  static _KColorPrimary primary = _KColorPrimary();
  static _KColorGreyScale greyScale = _KColorGreyScale();
  static _KColorStatus status = _KColorStatus();
}

class _KColorPrimary {
  /// 900 - #151C00
  final Color p900 = Color(0xFF151C00);

  /// 800 - #405500
  final Color p800 = Color(0xFF405500);

  /// 700 - #6B8E00
  final Color p700 = Color(0xFF6B8E00);

  /// 600 - #96C600
  final Color p600 = Color(0xFF96C600);

  /// 500 - #C1FF00
  final Color p500 = Color(0xFFC1FF00);

  /// 400 - #CFFF39
  final Color p400 = Color(0xFFCFFF39);

  /// 300 - #DDFF71
  final Color p300 = Color(0xFFDDFF71);

  /// 200 - #EAFFAA
  final Color p200 = Color(0xFFEAFFAA);
}

class _KColorGreyScale {
  /// 1000 - #0F0F0F
  final Color g1000 = Color(0xFF0F0F0F);

  /// 900 - #2C2C2C
  final Color g900 = Color(0xFF2C2C2C);

  /// 800 - #4A4A4A
  final Color g800 = Color(0xFF4A4A4A);

  /// 700 - #676767
  final Color g700 = Color(0xFF676767);

  /// 600 - #848484
  final Color g600 = Color(0xFF848484);

  /// 550 - #939393
  final Color g550 = Color(0xFF939393);

  /// 500 - #9E9E9E
  final Color g500 = Color(0xFF9E9E9E);

  /// 400 - #B3B3B3
  final Color g400 = Color(0xFFB3B3B3);

  /// 300 - #C9C9C9
  final Color g300 = Color(0xFFC9C9C9);

  /// 200 - #DFDFDF
  final Color g200 = Color(0xFFDFDFDF);

  /// 100 - #F4F4F4
  final Color g100 = Color(0xFFF4F4F4);
}

class _KColorStatus {
  /// Success - #00D33F
  final Color success = Color(0xFF00D33F);

  /// Warning - #FFCC00
  final Color warning = Color(0xFFFFCC00);

  /// Error - #C50000
  final Color error = Color(0xFFC50000);
}
