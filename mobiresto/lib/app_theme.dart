import 'package:flutter/material.dart';
import 'constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme lightTextTheme = TextTheme(
    headline1: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        color: primaryDarkColor),
    headline2: GoogleFonts.roboto(
        fontSize: 18, fontWeight: FontWeight.bold, color: primaryDarkColor),
    bodyText1: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        color: textColor),
  );
  static ThemeData lightTheme() {
    return ThemeData(
      textTheme: lightTextTheme,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
      textSelectionTheme:
          const TextSelectionThemeData(selectionColor: primaryDarkColor),
    );
  }
}
