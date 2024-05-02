import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottonNavigetionController extends GetxController {
  final index = 0.obs;
  final icon = [
    BottomNavigetionModel(
      icon: Icons.home_filled,
    ),
    BottomNavigetionModel(
      icon: Icons.shopping_cart_rounded,
    ),
    BottomNavigetionModel(
      icon: Icons.tag_faces_rounded,
    ),
    BottomNavigetionModel(
      icon: Icons.person,
    ),
  ];
}

class BottomNavigetionModel {
  IconData? icon;
  BottomNavigetionModel({
    required this.icon,
  });
}
