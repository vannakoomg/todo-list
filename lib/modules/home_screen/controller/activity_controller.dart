import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/home_screen/model/activity_model.dart';

import '../../../helpers/api_base_helper.dart';

class ActivityController extends GetxController {
  final isloading = false.obs;
  final activity = ActivityModel().obs;
  Future fetchActivityDetail(int id) async {
    isloading.value = true;
    ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
            url: "/ppm_sale/api/detail/activity?id=$id",
            methode: METHODE.post,
            isAuthorize: true)
        .then((value) {
      debugPrint("value $value");
      activity.value = ActivityModel.fromJson(value["data"]);
      isloading.value = false;
    }).onError((error, stackTrace) {
      isloading.value = false;
    });
  }
}
