import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/checkOut/controller/kkkk.dart';
import 'package:googlemap_ui/modules/home_screen/controller/home_controller.dart';
import 'package:googlemap_ui/utils/fuction.dart';

class CheckOutController extends GetxController {
  final homeController = Get.put(HomeController());
  final hasOrder = false.obs;
  final remark = ''.obs;
  final remarkText = TextEditingController().obs;
  final photo = File('').obs;
  final isloading = false.obs;

  void takePhoto() async {
    debugPrint("sdfdsfsdfdsf");
    photo.value = await pickImage();
    await compressImage(photo.value);
  }

  Future checkOut({
    required double lat,
    required double long,
    required int checkInId,
    required int routeId,
  }) async {
    isloading.value = true;
    if (hasOrder.value) {
      try {
        await checkOutSaleWithOrder(
          lat: lat,
          long: long,
          checkInId: checkInId,
          routeId: routeId,
          file: photo.value,
          remark: remark.value,
        );
        homeController.saleData.value.data![homeController.indexOfSale].status =
            "check-out-with-order";
      } catch (value) {
        debugPrint("you on cahlkaflkasjflksadjlf");
      }
    } else {
      await checkOutSale(
        lat: lat,
        long: long,
        checkInId: checkInId,
        routeId: routeId,
        file: photo.value,
        remark: remark.value,
      );
      homeController.saleData.value.data![homeController.indexOfSale].status =
          "check-out";
    }
    homeController.saleData.refresh();
    remark.value = '';
    remarkText.value.text = '';
    photo.value = File('');
    hasOrder.value = false;
    isloading.value = false;
    Get.back();
  }
}
