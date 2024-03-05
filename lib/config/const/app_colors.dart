import 'package:flutter/material.dart';

extension AppColor on Color {
  // for widget
  static var primaryColor = Colors.white;
  static var secondnaryColor = const Color(0xff208b3a);
  static var backgroundColor = const Color.fromARGB(255, 217, 217, 217);
  static var mainColor = Colors.black;
  //for font
  static var textFirst = const Color.fromARGB(255, 8, 8, 8);
  static var textSec = const Color(0xffe9ecef);
  static var textThird = const Color.fromARGB(255, 142, 142, 142);
  static var textfourth = const Color.fromARGB(255, 85, 84, 84);

  // for button
  static var warningColor = const Color.fromARGB(255, 1, 87, 168);
  static var dangerColor = const Color.fromARGB(255, 201, 3, 60);
  static var successColor = const Color.fromARGB(255, 1, 120, 41);
}
