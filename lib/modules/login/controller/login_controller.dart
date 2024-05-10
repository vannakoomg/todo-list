import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/helpers/api_base_helper.dart';
import 'package:googlemap_ui/helpers/local_storage.dart';
import 'package:googlemap_ui/utils/fuction.dart';
import 'package:googlemap_ui/utils/widgets/custom_alert.dart';

import '../../bottom_navigetion/screen/buttom_navigetion_screen.dart';

class LoginController extends GetxController {
  final userName = ''.obs;
  final passWord = ''.obs;
  final userNameText = TextEditingController().obs;
  final passWordText = TextEditingController().obs;
  final isloading = false.obs;
  final hidePassWord = true.obs;
  Future login(BuildContext context) async {
    unFocus();
    isloading.value = true;
    String deviceName = await getDeviceName(context);
    debugPrint("device Name = $deviceName");
    ApiBaseHelper.apiBaseHelper.onNetworkRequesting(
        url: "/ppm_sale/api/login",
        methode: METHODE.post,
        isAuthorize: false,
        body: {
          "jsonrpc": "2.0",
          "method": "call",
          "params": {
            "device_id": "odoo16_ppm_pharmacy",
            "username": "$userName",
            "password": "$passWord"
          }
        }).then((value) async {
      debugPrint("value $value ");
      await LocalStorage.storeData(
          key: "access_token", value: value["result"]["token"]);
      await LocalStorage.storeData(key: "mode", value: 0);
      await LocalStorage.storeData(key: "email", value: userName.value);
      isloading.value = false;
      passWordText.value.text = "";
      passWord.value = "";
      Get.offAll(() => const BottomNavigetionScreen());
    }).onError((error, stackTrace) {
      isloading.value = false;
      CustomDialog.error(
        title: "Oops",
        message: "User Name or Passwork Incorrect. Please try again !",
      );
    });
  }
}
