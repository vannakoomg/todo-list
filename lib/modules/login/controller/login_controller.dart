import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/helpers/api_base_helper.dart';
import 'package:googlemap_ui/utils/fuction.dart';

class LoginController extends GetxController {
  final userName = ''.obs;
  final passWord = ''.obs;
  final userNameText = TextEditingController().obs;
  final passWordText = TextEditingController().obs;
  Future login(BuildContext context) async {
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
            "username": "admin",
            "password": "admin"
          }
        }).then((value) {
      debugPrint("data ${value["result"]["token"]}");
    }).onError((error, stackTrace) {
      debugPrint("error $error");
    });
  }
}
