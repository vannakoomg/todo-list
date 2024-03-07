import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/helpers/api_base_helper.dart';
import 'package:googlemap_ui/modules/checkOut/screens/checkout_screen.dart';
import 'package:googlemap_ui/modules/todo/screen/check_in.dart';

import '../../../helpers/local_storage.dart';
import '../model/sale_model.dart';
import '../screen/activity_detail.dart';

class HomeController extends GetxController {
  final token = ''.obs;
  final isloading = false.obs;
  final indexOfSale = 0.obs;
  final currentlat = 0.0.obs;
  final currentlng = 0.0.obs;
  final saleData = SaleModel().obs;

  Future fetchSale() async {
    final userId = await LocalStorage.getIntValue(key: "user_id");

    isloading.value = true;
    ApiBaseHelper.apiBaseHelper.onNetworkRequesting(
      url: "/ppm_sale/api/sale_activity_today?user_id=$userId",
      methode: METHODE.post,
      isAuthorize: true,
      body: {},
    ).then((value) {
      debugPrint("data d");
      saleData.value = SaleModel.fromJson(value);
      isloading.value = false;
    }).onError((error, stackTrace) {
      debugPrint("error ");
      isloading.value = false;
    });
  }

  void ontapSaleActivity({
    required String status,
    required double lat,
    required double lng,
    required double photoLat,
    required double photolong,
    required int checkInId,
    required String name,
    required String date,
    required bool hasOrder,
    required String urlImage,
    required String remark,
  }) {
    debugPrint(status);
    if (status == "todo") {
      Get.to(() => CheckInScreen(
            name: name,
            lat: lat,
            long: lng,
            checkInId: checkInId,
          ));
    } else if (status == "check-in") {
      Get.to(() => CheckOutScreen(
            lat: lat,
            long: lng,
            checkInId: checkInId,
          ));
    } else {
      Get.to(() => ReportCheckOut(
            id: checkInId,
          ));
    }
  }

  Future getCurrentLocation() async {
    Position location = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentlat.value = location.latitude;
    currentlng.value = location.longitude;
  }

  Future fetchActivityDetail() async {
    ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
            url: "/ppm_sale/api/detail/activity",
            methode: METHODE.post,
            isAuthorize: true)
        .then((value) {})
        .onError((error, stackTrace) {});
  }
}
