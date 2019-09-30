import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color.fromARGB(255, 255, 241, 159);
  static const Color commentColor = Color.fromARGB(255, 255, 246, 196);

  static const Map<int, Color> appBlue = {
    50: Color.fromRGBO(16, 137, 255, .1),
    100: Color.fromRGBO(16, 137, 255, .2),
    200: Color.fromRGBO(16, 137, 255, .3),
    300: Color.fromRGBO(16, 137, 255, .4),
    400: Color.fromRGBO(16, 137, 255, .5),
    500: Color.fromRGBO(16, 137, 255, .6),
    600: Color.fromRGBO(16, 137, 255, .7),
    700: Color.fromRGBO(16, 137, 255, .8),
    800: Color.fromRGBO(16, 137, 255, .9),
    900: Color.fromRGBO(16, 137, 255, 1),
  };

  static const Map<int, Color> appBlueGrey = {
    50: Color.fromRGBO(35, 55, 77, .1),
    100: Color.fromRGBO(35, 55, 77, .2),
    200: Color.fromRGBO(35, 55, 77, .3),
    300: Color.fromRGBO(35, 55, 77, .4),
    400: Color.fromRGBO(35, 55, 77, .5),
    500: Color.fromRGBO(35, 55, 77, .6),
    600: Color.fromRGBO(35, 55, 77, .7),
    700: Color.fromRGBO(35, 55, 77, .8),
    800: Color.fromRGBO(35, 55, 77, .9),
    900: Color.fromRGBO(35, 55, 77, 1),
  };

  static const MaterialColor appMaterialBlue = MaterialColor(
    0xFF1089FF,
    appBlue,
  );

  static const MaterialColor appMaterialGrey = MaterialColor(
    0xFF23374D,
    appBlueGrey,
  );
}
