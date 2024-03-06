// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/checkOut/controller/kkkk.dart';
import 'package:googlemap_ui/modules/home_screen/controller/home_controller.dart';
import 'package:googlemap_ui/modules/todo/widgets/you_not_in_distance.dart';
import 'package:googlemap_ui/utils/fuction.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/single_ton.dart';

class CheckOutController extends GetxController {
  final oldRemark = "".obs;
  final oldHasOrder = false.obs;
  final homeController = Get.put(HomeController());
  final hasOrder = false.obs;
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
    if ((oldRemark.value == remark.value &&
            oldHasOrder.value == hasOrder.value &&
            photo.value.path == "") ||
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

  Future checkOut({
    required int checkInId,
    required BuildContext context,
  }) async {
    unFocus(context);
    if (currentlat.value == 0) {
      isloading.value = true;
      await getCurrentLocation();
    }
    double disabled = Geolocator.distanceBetween(
        shoplat.value, shoplong.value, currentlat.value, currentlng.value);
    if (disabled < 70) {
      isloading.value = true;
      if (hasOrder.value) {
        try {
          await checkOutSaleWithOrder(
            lat: currentlat.value,
            long: currentlng.value,
            checkInId: checkInId,
            file: photo.value,
            remark: remark.value,
          ).then((value) {});
          homeController.saleData.value.data![homeController.indexOfSale.value]
              .status = "check-out-order";
        } catch (value) {
          debugPrint("you on cahlkaflkasjflksadjlf");
        }
      } else {
        await checkOutSale(
          lat: currentlat.value,
          long: currentlng.value,
          checkInId: checkInId,
          file: photo.value,
          remark: remark.value,
        ).then((value) {});
        homeController.saleData.value.data![homeController.indexOfSale.value]
            .status = "check-out";
      }
      if (Singleton.obj.isCheckOut.value == true) {
        homeController.saleData.refresh();
        remark.value = '';
        remarkText.value.text = '';
        photo.value = File('');
        hasOrder.value = false;
        Get.back();
      } else {
        Get.defaultDialog(
            titlePadding: const EdgeInsets.only(top: 20),
            contentPadding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            title: "OOPS !",
            titleStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColor.dangerColor),
            content: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "SOMETHING WENT WRONG PLEASE TRY AGAIN",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              ],
            ));
      }
      isloading.value = false;
    } else {
      await youNotinLocation(context,
          "Unable to Check out. Your coordinates are not within range.");
    }
  }
}
