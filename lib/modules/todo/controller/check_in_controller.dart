// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/helpers/api_base_helper.dart';
import 'package:googlemap_ui/modules/checkOut/screens/checkout_screen.dart';
import 'package:googlemap_ui/modules/home_screen/controller/home_controller.dart';
import 'package:googlemap_ui/modules/home_screen/model/sale_model.dart';
import 'package:googlemap_ui/modules/todo/models/customer_model.dart';
import 'package:googlemap_ui/modules/todo/screen/map_detail.dart';
import 'package:googlemap_ui/utils/widgets/custom_alert.dart';

import '../../../helpers/local_storage.dart';
import '../widgets/allow_location.dart';
import '../widgets/you_not_in_distance.dart';

class ChcekinController extends GetxController {
  final isShowCustomer = false.obs;
  final homeController = Get.put(HomeController());
  final address = "".obs;
  final currentlat = 0.0.obs;
  final currentlng = 0.0.obs;
  final isloading = false.obs;
  void ontapCheckIn({
    required BuildContext context,
    required double shopLat,
    required double shopLong,
    required int checkInID,
  }) async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      if (currentlat.value == 0 || currentlng.value == 0) {
        await getCurrentLocation();
      }
      double disabled = Geolocator.distanceBetween(
          shopLat, shopLong, currentlat.value, currentlng.value);
      if (disabled < homeController.gpsRange.value) {
        checkInActivity(checkInID).then((value) {
          homeController.saleData.value.data![homeController.indexOfSale.value]
              .status = "check-in";
          homeController.saleData.refresh();
          Get.back();
          Get.to(
            () => CheckOutScreen(
              checkInId: checkInID,
              lat: shopLat,
              long: shopLong,
            ),
          );
        });
      } else {
        youNotinLocation(context,
            "Unable to check in. Your coordinates are not within range.");
      }
    } else {
      allowlocaiton(context);
    }
  }

  Future checkInActivity(int checkInId) async {
    isloading.value = true;
    await ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url: "/ppm_sale/api/check_in/activity?check_in_id=$checkInId",
      methode: METHODE.post,
      isAuthorize: true,
    )
        .then((value) {
      isloading.value = false;
      debugPrint("value $value ");
    }).onError((error, stackTrace) {
      isloading.value = false;
    });
  }

  Future getCurrentLocation() async {
    Position location = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentlat.value = location.latitude;
    currentlng.value = location.longitude;
  }

  Future getaddress(double lat, double long) async {
    await getAddressFromLatLng(lat, long).then(
      (value) {
        address.value = value;
      },
    ).onError(
      (error, stackTrace) {
        address.value = "";
      },
    );
  }

  Future<String> getAddressFromLatLng(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address =
            "${place.street} ${place.isoCountryCode}, ${place.subLocality}, ${place.locality}, ${place.country}";
        debugPrint("address $address");
        return address;
      } else {
        return 'No Address Found';
      }
    } catch (e) {
      return 'Not Found';
    }
  }

  void showMapDetail(
      BuildContext context, double lat, double long, String title) {
    showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.95,
            child: MapDetail(lat: lat, long: long, title: title));
      },
    );
  }

  // customer
  // final customer = CustomerModel().obs;
  final selectIndex = 1000.obs;
  final shopName = ''.obs;
  final shopLat = 0.0.obs;
  final shopLong = 0.0.obs;
  final paraterId = 0.obs;
  // final customer = OrderCustomModel().obs;

  // Future fetchCustomer() async {
  //   isloading.value = true;
  //   ApiBaseHelper.apiBaseHelper
  //       .onNetworkRequesting(
  //           url: "/ppm_sale/api/fetch_customer",
  //           methode: METHODE.post,
  //           isAuthorize: true)
  //       .then((value) {
  //     customer.value = CustomerModel.fromJson(value);
  //     isloading.value = false;
  //   }).onError((error, stackTrace) {
  //     isloading.value = false;
  //     debugPrint("eroor $error");
  //   });
  // }

  void onselected(
      int index, String name, double lat, double long, int parater) async {
    paraterId.value = parater;
    shopLat.value = lat;
    shopLong.value = long;
    selectIndex.value = index;

    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        isShowCustomer.value = !isShowCustomer.value;
      },
    );
    Future.delayed(const Duration(milliseconds: 250), () {
      shopName.value = name;
    });
    await getaddress(lat, long);
  }

  Future checkinNewCustomer(BuildContext context) async {
    isShowCustomer.value = false;
    isloading.value = true;
    final userId = await LocalStorage.getIntValue(key: "user_id");
    debugPrint("ssssssss$paraterId $userId");

    ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url: "/ppm_sale/api/new/activity?partner_id=$paraterId&user_id=$userId",
      methode: METHODE.post,
      isAuthorize: true,
    )
        .then((value) {
      debugPrint("value $value");
      homeController.saleData.value.data!.insert(
        0,
        Sale(
          address: "",
          hasOrder: false,
          status: "check-in",
          checkInDate: "",
          checkOutDate: "",
          lat: shopLat.value,
          long: shopLong.value,
          photo: "",
          customerCode: "",
          customerName: shopName.value,
          photoLat: "",
          photoLong: "",
          remark: "",
          userId: 2,
          id: value["data"]["check_in_id"],
        ),
      );
      homeController.indexOfSale.value = 0;
      homeController.saleData.refresh();
      Get.back();
      Get.to(
        () => CheckOutScreen(
          lat: shopLat.value,
          long: shopLong.value,
          checkInId: value["data"]["check_in_id"],
        ),
      );
      isloading.value = false;
    }).onError((error, stackTrace) {
      isloading.value = false;

      CustomDialog.error(
        message: "SOMETHING WENT WRONG PLEASE TRY AGAIN",
        title: "OOPS !",
      );
      debugPrint("errrrorrr $error");
    });
  }
}
