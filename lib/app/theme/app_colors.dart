import 'package:flutter/material.dart';
import 'dart:core';

abstract class AppColors {
  MaterialColor get primary;
  MaterialColor get swatch;

  Color get labelLogin;
  Color get verde;
  Color get preto;
  Color get branco;

  final String hex = '0xff';
  final String colorFinal = 'cf1f36';
  final int hexFinal = 0;

  final String colorSwatch = 'cf1f36';
  final int hexSwatch = 0;
}

class AppColorDefault implements AppColors {
  Map<int, Color> color = {
    50: const Color.fromRGBO(207, 31, 54, .1),
    100: const Color.fromRGBO(207, 31, 54, .2),
    200: const Color.fromRGBO(207, 31, 54, .3),
    300: const Color.fromRGBO(207, 31, 54, .4),
    400: const Color.fromRGBO(207, 31, 54, .5),
    500: const Color.fromRGBO(207, 31, 54, .6),
    600: const Color.fromRGBO(207, 31, 54, .7),
    700: const Color.fromRGBO(207, 31, 54, .8),
    800: const Color.fromRGBO(207, 31, 54, .9),
    900: const Color.fromRGBO(207, 31, 54, 1),
  };

  @override
  String get hex => '0xff';

  //009342 - PAPAGAIO - cf1f36 BIO //004357 Cor legal
  //246EE9 Royal Blue //FF2400 Scarlet Red //3EB489 Mint Green
  @override
  String get colorFinal => 'cf1f36';

  @override
  String get colorSwatch => 'FFFFFF';

  @override
  int get hexFinal => int.parse('$hex$colorFinal');

  @override
  int get hexSwatch => int.parse('$hex$colorSwatch');

  @override
  MaterialColor get primary => MaterialColor(hexFinal, color);

  @override
  MaterialColor get swatch => MaterialColor(hexSwatch, color);

  @override
  Color get labelLogin => Colors.black;

  @override
  Color get verde => Colors.green;

  @override
  Color get preto => Colors.black;

  @override
  Color get branco => Colors.white;
}
