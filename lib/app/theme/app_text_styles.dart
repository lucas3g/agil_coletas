import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  TextStyle get labelLogin;
}

class AppTextStylesDefault implements AppTextStyles {
  @override
  TextStyle get labelLogin => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppTheme.colors.labelLogin,
      );
}
