import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  TextStyle get labelLogin;
  TextStyle get titleAlertDialog;
  TextStyle get contentAlertDialog;
}

class AppTextStylesDefault implements AppTextStyles {
  @override
  TextStyle get labelLogin => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppTheme.colors.labelLogin,
      );

  @override
  TextStyle get titleAlertDialog => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppTheme.colors.primary,
      );

  @override
  TextStyle get contentAlertDialog => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );
}
