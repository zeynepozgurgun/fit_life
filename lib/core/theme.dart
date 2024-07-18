import 'package:flutter/material.dart';

const ColorScheme colors = const ColorScheme(
  primary: const Color(0xFFf1f7d7),
  onPrimary: const Color(0xFFfbe3a3),
  secondary: const Color(0xFF206380),
  onSecondary: const Color(0xFF154459),
  surface: const Color(0xFF39bebe),
  error: const Color(0xffF9371D),
  onPrimaryContainer: const Color(0xffA2AAAB),
  onError: const Color(0xFF9AFFFF),
  onSurface: const Color(0xFF49454F),
  brightness: Brightness.light,
);

final ThemeData appTheme = ThemeData(
  colorScheme: colors,
  textTheme: TextTheme(
    titleLarge: TextStyle( //APP NAME
      fontFamily: 'Roboto',
      fontSize: 30.0,
      fontWeight: FontWeight.w800,
      color: colors.onSecondary,
    ),
  
    titleMedium: TextStyle( //WELCOME TEXT + Setting options
    fontFamily: 'Roboto',
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: colors.onSecondary),

    titleSmall: TextStyle( //LOGIN / SETTINGS / MY ACCOUNT
    fontFamily: 'Roboto',
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
    color: colors.secondary),

    headlineSmall: TextStyle( //username: + cont without an acc. + warnings
    fontFamily: 'Roboto',
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: colors.secondary,),

    headlineMedium: TextStyle( //you havent signed up to an account
    fontFamily: 'Roboto',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: colors.secondary,),

    headlineLarge: TextStyle( //Labels for personal info (height weight etc.)
    fontFamily: 'Roboto',
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: colors.onPrimary),

    displayLarge: TextStyle( //DIET HEADLINES 
    fontFamily: 'Roboto',
    fontSize: 24.0,
    fontWeight: FontWeight.w800,
    color: colors.onSecondary),

    displayMedium: TextStyle( //DIET DETAIL HEADLINES
    fontFamily: 'Roboto',
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    color: colors.onSecondary),
  
    displaySmall: TextStyle( //DIET info + personal info + username password enter
    fontFamily: 'Roboto',
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
    color: colors.onSurface),

    bodyLarge: TextStyle( //choose all that apply / search for keywords
    fontFamily: 'Roboto',
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
    color: colors.onPrimaryContainer,
    ),

    bodyMedium: TextStyle( //edit / done
    fontFamily: 'Roboto',
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
    color: colors.primary,
    ),

    bodySmall: TextStyle( //credits
    fontFamily: 'Roboto',
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: colors.onError,
    )
  )
);