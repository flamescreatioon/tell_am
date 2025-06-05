import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: const Color.fromARGB(255, 241, 239, 231),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(255, 241, 239, 231),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: GoogleFonts.leagueSpartan(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.leagueSpartan(
        fontSize: 38,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displayMedium: GoogleFonts.leagueSpartan(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displaySmall: GoogleFonts.leagueSpartan(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleLarge: GoogleFonts.leagueSpartan(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleMedium: GoogleFonts.leagueSpartan(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      // Body text and input fields
      bodyLarge: GoogleFonts.quicksand(
        fontSize: 18,
        color: Colors.black87,
      ),
      bodyMedium: GoogleFonts.quicksand(
        fontSize: 16,
        color: Colors.black87,
      ),
      bodySmall: GoogleFonts.quicksand(
        fontSize: 14,
        color: Colors.black87,
      ),
      labelLarge: GoogleFonts.quicksand(
        fontWeight: FontWeight.w600,
      ),
      labelMedium: GoogleFonts.quicksand(),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 241, 239, 231), //#f1efe7
      selectedItemColor: Color.fromARGB(255, 255, 145, 77), //#ff914d
      unselectedItemColor: Colors.black, //#000000
      showUnselectedLabels: true,
      showSelectedLabels: true,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: const Color.fromARGB(255, 30, 30, 30),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 30, 30, 30),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.leagueSpartan(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 30, 30, 30),
      selectedItemColor: Color.fromARGB(255, 255, 145, 77),
      unselectedItemColor: Colors.white,
      showUnselectedLabels: true,
      showSelectedLabels: true,
    ),
  );
}
