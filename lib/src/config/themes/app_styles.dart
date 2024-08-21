import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppStyles {
  static final TextStyle _baseStyle = GoogleFonts.inter();

  static final TextStyle s14w400 = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle s18w500 = _baseStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle s20w600 = _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
}
