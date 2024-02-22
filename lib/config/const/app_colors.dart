import 'package:flutter/material.dart';

extension AppColor on Color {
  // for widget
  static var primaryColor = Colors.white;
  static var secondnaryColor = Color.fromARGB(255, 6, 120, 214);
  static var backgroundColor = const Color.fromARGB(255, 255, 255, 255);
  static var mainColor = Colors.black;
  //for font
  static var textFirst = const Color.fromARGB(255, 8, 8, 8);
  static var textSec = const Color(0xffe9ecef);
  static var textThird = const Color.fromARGB(255, 142, 142, 142);
  static var textfourth = const Color.fromARGB(255, 85, 84, 84);

  // for button
  static var buttonColor = const Color.fromARGB(255, 219, 22, 81);
  static var warningColor = const Color(0xffAAA505);
  static var dangerColor = const Color.fromARGB(255, 240, 38, 65);
  static var successColor = const Color.fromARGB(255, 46, 137, 61);
}
