import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/helpers/api_base_helper.dart';
import 'package:googlemap_ui/utils/widgets/custom_alert.dart';

import '../../../helpers/local_storage.dart';

class UserInfoContorller extends GetxController {
  final isLoaing = false.obs;
  final oldPassword = ''.obs;
  final oldPasswordText = TextEditingController().obs;
  final newPassword = ''.obs;
  final newPasswordText = TextEditingController().obs;
  final old = ''.obs;
  void fetchOldPassword() async {
    old.value = await LocalStorage.getStringValue(key: "password");
  }

  Future changePassword() async {
    isLoaing.value = true;

    await ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
          url:
              "/ppm_sale/api/user/new-password?new_password=${newPassword.value}",
          methode: METHODE.post,
          isAuthorize: true,
        )
        .then(
          (value) async => {
            debugPrint("new token ${value["data"]["token"]}"),
            await LocalStorage.storeData(
                key: "password", value: newPassword.value),
            await LocalStorage.storeData(
                key: "access_token", value: value["data"]["token"]),
            old.value = newPassword.value,
            isLoaing.value = false,
            CustomDialog.success(
                title: "DONE",
                message: "Your Password updated!",
                ontap: () {
                  Get.back();
                  Get.back();
                }),
          },
        );
  }
}
