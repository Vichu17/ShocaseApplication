import 'package:app/Helper/String.dart';
import 'package:flutter/material.dart';


class colors {
  colors._();

  static const MaterialColor primary_app = const MaterialColor(
    0xffFE7E7B,
    const <int, Color>{
      50: primary,
      100: primary,
      200: primary,
      300: primary,
      400: primary,
      500: primary,
      600: primary,
      700: primary,
      800: primary,
      900: primary,
    },
  );

  // static const Color primary = Color(0xFF0e2149);
  static const Color primary = Color(0xFF000000);
  // static const Color secondary = Color(0xFF0e2149);
  static const Color secondary = Color(0xffEEF2F3);

  static Color get fontColor => ISDARK == "true" ? secondary : const Color(0xffFFFFFF);
  static const Color grad1Color = Color(0xFF0e2149);
  static const Color grad2Color = Color(0xFF0e2149);
  static const Color lightWhite2 = Color(0xffEEF2F3);

  static const Color pink = Color(0xffd4001d);
  static const Color red = Colors.red;

  static Color get lightBlack =>
      ISDARK == "true" ? whiteTemp : const Color(0xff000000);

  static Color get lightBlack2 =>
      ISDARK == "true" ? white70 : const Color(0xff000000);

  static Color get lightWhite =>
      ISDARK == "true" ? darkColor : const Color(0xFF0e2149);

  static const Color darkColor = Color(0xFF0e2149);
  static const Color darkColor2 = Color(0xffFFFFFF);

  static Color get white => ISDARK == "true" ? darkColor2 : const Color(0xffFFFFFF);
  static const Color whiteTemp = Color(0xff000000);

  static Color get black => ISDARK == "true" ? whiteTemp : const Color(0xff000000);

  static const Color white10 = Colors.white10;
  static const Color white30 = Colors.white30;
  static const Color white70 = Colors.white70;

  static const Color black54 = Colors.black54;
  static const Color black12 = Colors.black12;
  static const Color disableColor=Color(0xffEEF2F9);
  static Color get black26 => ISDARK == "true" ? white30 : Colors.black26;
}
