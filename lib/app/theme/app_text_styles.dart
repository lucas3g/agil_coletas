import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  TextStyle get labelLogin;
  TextStyle get titleAlertDialog;
  TextStyle get titleListaColetas;
  TextStyle get titleCardListaColetas;
  TextStyle get subTitleCardListaColetas;
  TextStyle get contentAlertDialog;
  TextStyle get titleAppBar;
  TextStyle get titleDrawer;
  TextStyle get subtitleDrawer;
  TextStyle get titleCardTransp;
  TextStyle get titleCardTranspBold;
  TextStyle get subTitleCardTransp;
  TextStyle get subTitleCardTranspBold;
  TextStyle get titleAlertTransp;
  TextStyle get subTitleAlertTransp;
  TextStyle get titleListTikets;
  TextStyle get subTitleListTikets;
  TextStyle get labelButtonFinalizar;
  TextStyle get labelTotalColetadoRed;
  TextStyle get labelTotalColetadoBlack;
  TextStyle get subtitleCardImpressora;
  TextStyle get labelNotFound;
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
        color: AppTheme.colors.preto,
      );

  @override
  TextStyle get titleAppBar => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  @override
  TextStyle get titleDrawer => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  @override
  TextStyle get subtitleDrawer => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppTheme.colors.preto,
      );

  @override
  TextStyle get titleCardTransp => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppTheme.colors.preto,
      );
  @override
  TextStyle get titleCardTranspBold => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppTheme.colors.preto,
      );

  @override
  TextStyle get subTitleCardTranspBold => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppTheme.colors.preto,
      );

  @override
  TextStyle get subTitleCardTransp => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppTheme.colors.preto,
      );

  @override
  TextStyle get titleAlertTransp => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppTheme.colors.preto,
      );

  @override
  TextStyle get subTitleAlertTransp => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppTheme.colors.preto,
      );

  @override
  TextStyle get titleListaColetas => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppTheme.colors.primary,
      );

  @override
  TextStyle get subTitleCardListaColetas => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppTheme.colors.preto,
      );

  @override
  TextStyle get titleCardListaColetas => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppTheme.colors.preto,
      );

  @override
  TextStyle get subTitleListTikets => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppTheme.colors.preto,
      );

  @override
  TextStyle get titleListTikets => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppTheme.colors.preto,
      );

  @override
  TextStyle get labelButtonFinalizar => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppTheme.colors.primary,
      );

  @override
  TextStyle get labelTotalColetadoBlack => GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppTheme.colors.preto,
      );

  @override
  TextStyle get labelTotalColetadoRed => GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppTheme.colors.primary,
      );

  @override
  TextStyle get subtitleCardImpressora => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppTheme.colors.primary,
      );

  @override
  TextStyle get labelNotFound => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      );
}
