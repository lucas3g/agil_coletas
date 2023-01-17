import 'package:agil_coletas/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

abstract class AppBorderStyle {
  Border get borderRed;
  Border get borderGreen;
}

class AppBorderStylesDefault implements AppBorderStyle {
  @override
  Border get borderGreen => const Border(
        top: BorderSide(
          width: 10,
          color: Colors.green,
        ),
        bottom: BorderSide(
          width: 10,
          color: Colors.green,
        ),
      );

  @override
  Border get borderRed => Border(
        top: BorderSide(
          width: 10,
          color: AppTheme.colors.primary,
        ),
        bottom: BorderSide(
          width: 10,
          color: AppTheme.colors.primary,
        ),
      );
}
