import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}

const Color primaryColor = Color(0xFF32384A); // Green color as primary
const Color appBarColor = Color(0xff3a3e4e); // New app bar color for light theme
const Color darkAppBarColor = Color(0xff242629); // Dark app bar color
const Color textColor = Colors.white; // White text color
const Color inactiveIconColor = Colors.grey;
const Color BackGround = Color(0xffebebeb); // Light background color
const Color darkBackgroundColor = Color(0xff121212); // Dark background color

ThemeData lightTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.all(24),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
  ),
  primaryColor: primaryColor,
  scaffoldBackgroundColor: BackGround,
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    secondary: primaryColor,
    background: primaryColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: appBarColor,
    iconTheme: const IconThemeData(
      color: textColor,
    ),
    titleTextStyle: GoogleFonts.rubik(
      color: textColor,
      fontSize: 17,
    ),
  ),
  textTheme: GoogleFonts.rubikTextTheme(),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: primaryColor,
    selectedItemColor: textColor,
    unselectedItemColor: inactiveIconColor,
  ),
);

ThemeData darkTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.all(24),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
  ),
  primaryColor: primaryColor,
  scaffoldBackgroundColor: darkBackgroundColor,
  colorScheme: const ColorScheme.dark(
    primary: primaryColor,
    secondary: primaryColor,
    background: primaryColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: darkAppBarColor,
    iconTheme: const IconThemeData(
      color: textColor,
    ),
    titleTextStyle: GoogleFonts.rubik(
      color: textColor,
      fontSize: 17,
    ),
  ),
  textTheme: GoogleFonts.rubikTextTheme(),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: primaryColor,
    selectedItemColor: textColor,
    unselectedItemColor: inactiveIconColor,
  ),
);
