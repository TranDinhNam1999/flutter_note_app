import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: GoogleFonts.roboto(
            fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black),
        backgroundColor: primaryAppbarColor,
        centerTitle: true),
    scaffoldBackgroundColor: primaryColor,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    backgroundColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
    ),
    cardTheme: CardTheme(
      color: primaryColor,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 217, 97, 76),
      foregroundColor: secondaryColor,
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: primaryColor),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: const TextStyle(color: greenColor),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: greenColor),
        borderRadius: BorderRadius.circular(12),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: greenColor),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ))),
    ));
