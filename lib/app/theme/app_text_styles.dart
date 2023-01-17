import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  TextStyle get labelLogin;
  TextStyle get titleAlertDialog;
  TextStyle get contentAlertDialog;
  TextStyle get titleAppBar;
  TextStyle get titleDrawer;
  TextStyle get subtitleDrawer;
  TextStyle get titleCardTransp;
  TextStyle get titleCardTranspBold;
  TextStyle get subTitleCardTransp;
  TextStyle get subTitleCardTranspBold;
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
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

  @override
  TextStyle get titleAppBar => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  @override
  TextStyle get titleDrawer => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  @override
  TextStyle get subtitleDrawer => GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  @override
  TextStyle get titleCardTransp => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );
  @override
  TextStyle get titleCardTranspBold => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

  @override
  TextStyle get subTitleCardTranspBold => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

  @override
  TextStyle get subTitleCardTransp => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );
}
