import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const ColorScheme _colors = const ColorScheme(
  primary: const Color(0xFFf1f7d7),
  onPrimary: const Color(0xFFfbe3a3),
  secondary: const Color(0xFF206380),
  onSecondary: const Color(0xFF154459),
  surface: const Color(0xFF39bebe),
  error: const Color(0xffF9371D),
  onPrimaryContainer: const Color(0xffA2AAAB),
  onError: Color.fromARGB(255, 158, 216, 216),
  onSurface: const Color(0xFF49454F),
  brightness: Brightness.light,
);

final ThemeData appTheme = ThemeData(
  colorScheme: _colors,
  fontFamily: GoogleFonts.roboto().fontFamily,
  textTheme: TextTheme(
    titleLarge: TextStyle( //APP NAME
      fontSize: 30.0,
      fontWeight: FontWeight.w900,
      color: _colors.onSecondary,
    ),
  
    titleMedium: TextStyle( //WELCOME TEXT + Setting options
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: _colors.onSecondary),

    titleSmall: TextStyle( //LOGIN / SETTINGS / MY ACCOUNT
    fontSize: 25.0,
    fontWeight: FontWeight.w800,
    color: _colors.secondary),

    headlineSmall: TextStyle( //username: + cont without an acc. + warnings
    fontSize: 17.0,
    fontWeight: FontWeight.w600,
    color: _colors.secondary,),

    headlineMedium: TextStyle( //you havent signed up to an account
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: _colors.secondary,),

    headlineLarge: TextStyle( //Labels for personal info (height weight etc.)
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: _colors.onPrimary),

    displayLarge: TextStyle( //DIET HEADLINES
    fontSize: 24.0,
    fontWeight: FontWeight.w800,
    color: _colors.onSecondary),

    displayMedium: TextStyle( //DIET DETAIL HEADLINES
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    color: _colors.onSecondary),
  
    displaySmall: TextStyle( //DIET info + personal info + username password enter
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
    color: _colors.onSurface),

    bodyLarge: TextStyle( //choose all that apply / search for keywords
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
    color: _colors.onPrimaryContainer,
    ),

    bodyMedium: TextStyle( //edit / done
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
    color: _colors.primary,
    ),

    bodySmall: TextStyle( //credits
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: _colors.onError,
    )
  )
);