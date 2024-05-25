import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/helpers/local_storage.dart';
import 'package:googlemap_ui/modules/login/screen/login_screen.dart';

class SelectUrlController extends GetxController {
  final url = "".obs;
  final urlText = TextEditingController().obs;
  void submitUrl() async {
    await LocalStorage.storeData(
      key: "baseUrl",
      value: url.value,
    );
    String name = await LocalStorage.getStringValue(key: "email");
    Get.to(() => LoginScreen(
          userName: name,
        ));
  }
}
