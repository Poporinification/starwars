import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Light theme for the app
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primarySwatch: Colors.grey,
  fontFamily: 'Inter',
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: Colors.white,
  primaryTextTheme: TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 93,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 58,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
    ),
    displaySmall: GoogleFonts.inter(fontSize: 47, fontWeight: FontWeight.w400),
    headlineMedium: GoogleFonts.inter(
      fontSize: 33,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    headlineLarge: GoogleFonts.inter(
      fontSize: 29,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    headlineSmall: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w400),
    titleLarge: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.4,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
    ),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Color(0xFFF5F5F5),
    iconTheme: IconThemeData(
      color: Colors.black87,
      size: 24,
    ),
    toolbarTextStyle: TextStyle(
      color: Colors.black87,
      fontSize: 24,
      fontWeight: FontWeight.normal,
      fontFamily: 'Inter',
    ),
    titleTextStyle: TextStyle(
      color: Colors.black87,
      fontSize: 24,
      fontWeight: FontWeight.normal,
      fontFamily: 'Inter',
    ),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(Colors.grey[600]),
    trackColor: MaterialStateProperty.all(Colors.grey[300]),
    overlayColor: MaterialStateProperty.all(Colors.grey[100]),
  ),
);
