import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/helpers/api_base_helper.dart';
import 'package:googlemap_ui/helpers/local_storage.dart';
import 'package:googlemap_ui/modules/home_screen/screen/home_screen.dart';
import 'package:googlemap_ui/utils/fuction.dart';

class LoginController extends GetxController {
  final userName = ''.obs;
  final passWord = ''.obs;
  final userNameText = TextEditingController().obs;
  final passWordText = TextEditingController().obs;
  final isloading = false.obs;
  Future login(BuildContext context) async {
    if (userName.value != '' && passWord.value != '') {
      unFocus(context);
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
        await LocalStorage.storeData(
            key: "access_token", value: value["result"]["token"]);
        await LocalStorage.storeData(
            key: "user_id", value: value["result"]["user_id"]);
        String toke = await LocalStorage.getStringValue(key: "access_token");
        int userId = await LocalStorage.getIntValue(key: "user_id");
        debugPrint(" $userId");
        debugPrint(" $toke");
        isloading.value = false;
        Get.to(const HomeScreen());
      }).onError((error, stackTrace) {
        isloading.value = false;
        Get.defaultDialog(
          titlePadding: const EdgeInsets.only(top: 10, bottom: 10),
          contentPadding: const EdgeInsets.only(left: 20, right: 20),
          backgroundColor: Colors.white,
          title: "Oops",
          titleStyle: const TextStyle(color: Color(0xffad2e24)),
          content: Text(
            "User Name or Passwork Incorrect. Please try again !",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: const Color.fromARGB(255, 183, 51, 73)),
          ),
        );
        debugPrint("error kkkkkk $error");
      });
    }
  }
}
