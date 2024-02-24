import 'dart:io';

import 'package:get/get.dart';
import 'package:googlemap_ui/utils/fuction.dart';

class CheckOutController extends GetxController {
  final ischeck = false.obs;
  final photo = File('').obs;

  void takePhoto() async {
    photo.value = await pickImage();
  }
}
