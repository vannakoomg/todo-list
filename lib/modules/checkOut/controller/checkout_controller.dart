// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/checkOut/controller/kkkk.dart';
import 'package:googlemap_ui/modules/home_screen/controller/home_controller.dart';
import 'package:googlemap_ui/modules/todo/widgets/you_not_in_distance.dart';
import 'package:googlemap_ui/utils/fuction.dart';
import 'package:googlemap_ui/utils/widgets/custom_alert.dart';

import '../../../utils/single_ton.dart';

class CheckOutController extends GetxController {
  final isShowCustomer = false.obs;
  final oldRemark = "".obs;
  final homeController = Get.put(HomeController());
  final remark = ''.obs;
  final remarkText = TextEditingController().obs;
  final photo = File('').obs;
  final isloading = false.obs;
  final shoplat = 0.0.obs;
  final shoplong = 0.0.obs;
  final currentlat = 0.0.obs;
  final currentlng = 0.0.obs;

  Future getCurrentLocation() async {
    Position location = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentlat.value = location.latitude;
    currentlng.value = location.longitude;
  }

  bool validateUpdate() {
    if ((oldRemark.value == remark.value && photo.value.path == "") ||
        remark.value == "") {
      return true;
    } else {
      return false;
    }
  }

  Future takePhoto(BuildContext context) async {
    await checkPermission(context);
    photo.value = await pickImage();
    photo.value = await compressImage(photo.value);
  }

  //
  final distance = 0.0.obs;
  Future checkOut({
    required int checkInId,
    required BuildContext context,
  }) async {
    unFocus();
    if (currentlat.value == 0) {
      isloading.value = true;
      await getCurrentLocation();
    }
    if (shoplat.value != 0) {
      distance.value = Geolocator.distanceBetween(
          shoplat.value, shoplong.value, currentlat.value, currentlng.value);
    } else {
      distance.value = 1;
    }
    debugPrint("distance $distance");
    if (distance.value < homeController.gpsRange.value) {
      isloading.value = true;
      await checkOutSale(
        lat: currentlat.value,
        long: currentlng.value,
        checkInId: checkInId,
        file: photo.value,
        remark: remark.value,
      ).then((value) {});
      homeController.saleData.value.data![homeController.indexOfSale.value]
          .status = "check-out";

      if (Singleton.obj.isCheckOut.value == true) {
        CustomDialog.success(
            barrierDismissible: false,
            title: "success",
            message: "you check out successfully",
            ontap: () {
              homeController.saleData.refresh();
              remark.value = '';
              remarkText.value.text = '';
              photo.value = File('');
              Get.back();
              Get.back();
            });
      } else {
        CustomDialog.error(
          title: "OOPS !",
          message: "SOMETHING WENT WRONG PLEASE TRY AGAIN",
        );
      }
      isloading.value = false;
    } else {
      await youNotinLocation(
        context,
        "Unable to Check out. Your coordinates are not within range.",
      );
    }
  }
}
