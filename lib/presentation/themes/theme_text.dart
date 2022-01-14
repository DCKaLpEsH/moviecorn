import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  static TextStyle? get _whiteHeadline6 =>
      _poppinsTextTheme.headline6?.copyWith(
        fontSize: Sizes.dimen_16.sp.toDouble(),
        color: Colors.white,
      );

  static getTextTheme() => TextTheme(
        headline6: _whiteHeadline6,
        subtitle1: whiteSubtitle1,
        bodyText2: whiteBodyText2,
      );
  static TextStyle? get whiteSubtitle1 => _poppinsTextTheme.subtitle1?.copyWith(
        fontSize: Sizes.dimen_16.sp.toDouble(),
        color: Colors.white,
      );
  static TextStyle? get whiteBodyText2 => _poppinsTextTheme.bodyText2?.copyWith(
        color: Colors.white,
        fontSize: Sizes.dimen_14.sp.toDouble(),
        wordSpacing: 0.25,
        letterSpacing: 0.25,
      );
}

extension ThemeTextExtension on TextTheme {
  TextStyle get royalBlueSubtitle1 => subtitle1!.copyWith(
        color: AppColors.royalBlue,
        fontWeight: FontWeight.w600,
      );
}
