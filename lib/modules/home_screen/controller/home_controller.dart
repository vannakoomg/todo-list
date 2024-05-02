import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/helpers/api_base_helper.dart';
import 'package:googlemap_ui/modules/checkOut/screens/checkout_screen.dart';
import 'package:googlemap_ui/modules/home_screen/model/user_info_model.dart';
import 'package:googlemap_ui/modules/todo/screen/check_in.dart';

import '../model/sale_model.dart';
import '../screen/activity_detail.dart';

class HomeController extends GetxController {
  final token = ''.obs;
  final mode = 0.obs;
  final isloading = false.obs;
  final gpsRange = 0.0.obs;
  final indexOfSale = 0.obs;
  final currentlat = 0.0.obs;
  final currentlng = 0.0.obs;
  final saleData = SaleModel().obs;
  final fromDate = "".obs;
  final dateTo = "".obs;
  Future fetchSale({required String fromDate, required String dateTo}) async {
    // final userId = await LocalStorage.getIntValue(key: "user_id");

    isloading.value = true;
    ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url: "/ppm_sale/api/activity_report?date_from=$fromDate&date_to=$dateTo",
      methode: METHODE.post,
      isAuthorize: true,
    )
        .then((value) {
      debugPrint("ddddddddd");
      saleData.value = SaleModel.fromJson(value);
      isloading.value = false;
    }).onError((error, stackTrace) {
      debugPrint("error  eeeeeee ");
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

  final userInfo = UserInfoModel().obs;
  final dateSelected = "".obs;
  void fetchUserInfo() async {
    await ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
          url: "/ppm_sale/api/user/info",
          methode: METHODE.post,
          isAuthorize: true,
        )
        .onError((error, stackTrace) => {
              debugPrint("kkkkkkkkkkkk"),
            })
        .then(
          (value) => {
            userInfo.value = UserInfoModel.fromJson(value),
          },
        );
  }
}
