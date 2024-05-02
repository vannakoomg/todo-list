// import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
// import 'package:sos_mobile/configs/const/Colors/app_colors.dart';

// DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

ThemeData lightMode = ThemeData(
  datePickerTheme: const DatePickerThemeData(
    backgroundColor: Colors.orange,
  ),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: AppColor.secondnaryColor.withOpacity(0.6),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(
      color: AppColor.secondnaryColor, // Border color when unchecked
      width: 1.0,
    ),
  ),
  colorScheme: const ColorScheme.light(
    background: Color.fromARGB(255, 255, 255, 255),
    primary: Colors.black,
    secondary: Color.fromARGB(255, 209, 209, 209),
    tertiary: Color.fromARGB(255, 27, 27, 27),
    onPrimary: Color.fromARGB(255, 63, 63, 63),
    onSecondary: Color.fromARGB(255, 170, 170, 170),
    onTertiary: Color.fromARGB(255, 222, 222, 222),
  ),
  useMaterial3: true,
  brightness: Brightness.light,
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: AppColor.textFirst,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: AppColor.textFirst,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: AppColor.textFirst,
      fontSize: 15,
    ),
    bodyMedium: TextStyle(
      color: AppColor.textFirst,
      fontSize: 13,
    ),
    bodySmall: TextStyle(
      color: AppColor.textFirst,
      fontSize: 11,
    ),
  ),
);

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    background: Color.fromARGB(255, 26, 26, 26),
    primary: Colors.white,
    secondary: Color.fromARGB(255, 101, 101, 101),
    tertiary: Color.fromARGB(255, 207, 207, 207),
    onPrimary: Color.fromARGB(255, 198, 198, 198),
    onSecondary: Color.fromARGB(255, 68, 68, 68),
    onTertiary: Color.fromARGB(255, 45, 45, 45),
  ),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: AppColor.secondnaryColor.withOpacity(0.6),
  ),
  useMaterial3: true,
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 15,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 12,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 11,
    ),
  ),
);
