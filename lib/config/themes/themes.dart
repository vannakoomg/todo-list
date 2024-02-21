// import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
// import 'package:sos_mobile/configs/const/Colors/app_colors.dart';

// DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

ThemeData lightMode = ThemeData(
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: AppColor.secondnaryColor.withOpacity(0.6),
  ),
  colorScheme: ColorScheme.light(
    background: AppColor.backgroundColor,
    primary: Colors.black,
    secondary: Colors.white,
    tertiary: const Color.fromARGB(255, 27, 27, 27),

    ///--------------
    onPrimary: const Color.fromARGB(255, 113, 113, 113),
    onSecondary: const Color.fromARGB(255, 52, 52, 52),
    onTertiary: const Color.fromARGB(255, 45, 45, 45),
  ),
  useMaterial3: true,
  brightness: Brightness.light,
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: AppColor.textFirst,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: "Siemreap",
    ),
    titleMedium: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      color: AppColor.textFirst,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: "Siemreap",
    ),
    bodyLarge: TextStyle(
      color: AppColor.textFirst,
      fontSize: 15,
      fontFamily: "Siemreap",
    ),
    bodyMedium: TextStyle(
      color: AppColor.textFirst,
      fontSize: 13,
      fontFamily: "Siemreap",
    ),
    bodySmall: TextStyle(
      color: AppColor.textFirst,
      fontSize: 11,
      fontFamily: "Siemreap",
    ),
  ),
);

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    background: Colors.black,
    primary: Colors.white,
    secondary: Color.fromARGB(255, 77, 77, 77),
    tertiary: Color.fromARGB(255, 207, 207, 207),
    onPrimary: Color.fromARGB(255, 198, 198, 198),
    onSecondary: Color.fromARGB(255, 111, 111, 111),
    onTertiary: Color.fromARGB(255, 24, 24, 24),
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
      fontFamily: "Siemreap",
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontFamily: "Siemreap",
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: "Siemreap",
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontFamily: "Siemreap",
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontFamily: "Siemreap",
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 11,
      fontFamily: "Siemreap",
    ),
  ),
);
