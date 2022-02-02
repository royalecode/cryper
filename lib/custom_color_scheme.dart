import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  Color get backgroundVariant => brightness == Brightness.dark
      ? const Color(0xFF2A2F45)
      : const Color(0xfff4f4f4);

  Color get fieldBackground => brightness == Brightness.dark
      ? const Color(0xFF2A2F45)
      : const Color(0xffEBEFFF);

  Color get hint => brightness == Brightness.dark
      ? const Color(0xFFA4A8BD)
      : const Color(0xff8F9CFB);

  Color get chartLine => brightness == Brightness.dark
      ? const Color(0x30FFFFFF)
      : const Color(0x77000000);

/*  Color get backgroundVariant => brightness == Brightness.dark
      ? const Color(0xFF28a745)
      : const Color(0x2228a745);

  Color get backgroundVariant => brightness == Brightness.dark
      ? const Color(0xFF28a745)
      : const Color(0x2228a745);

  Color get backgroundVariant => brightness == Brightness.dark
      ? const Color(0xFF28a745)
      : const Color(0x2228a745);*/
}
