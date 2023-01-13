import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  TextStyle get labelLogin;
  TextStyle get titleSnackBar;
  TextStyle get subTitleSnackBar;
}

class AppTextStylesDefault implements AppTextStyles {
  @override
  TextStyle get labelLogin => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppTheme.colors.labelLogin,
      );

  @override
  TextStyle get titleSnackBar => GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );

  @override
  TextStyle get subTitleSnackBar => GoogleFonts.montserrat(
        fontSize: 12,
        color: Colors.white,
      );
}
