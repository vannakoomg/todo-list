import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/helpers/api_base_helper.dart';
import 'package:googlemap_ui/modules/checkOut/screens/checkout_screen.dart';
import 'package:googlemap_ui/modules/home_screen/screen/report_checkout.dart';
import 'package:googlemap_ui/modules/todo/screen/todo_detail.dart';
import 'package:intl/intl.dart';

import '../model/sale_model.dart';

class HomeController extends GetxController {
  final datetime = DateTime.now().obs;
  final isloading = false.obs;
  int indexOfSale = 0;

  final date = ''.obs;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: datetime.value,
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue, // Change this to your desired color
            ),
            dialogBackgroundColor: Colors.white, // Background color
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != datetime.value) {
      datetime.value = picked;
      date.value = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  final saleData = SaleModel().obs;

  Future fetchSale() async {
    debugPrint("dsfdsfdsf");
    isloading.value = true;
    ApiBaseHelper.apiBaseHelper
        .onNetworkRequesting(
      url: "/ppm_sale/api/sale_route_list?user_id=2",
      methode: METHODE.post,
      isAuthorize: true,
    )
        .then((value) {
      saleData.value = SaleModel.fromJson(value);
      isloading.value = false;
      debugPrint("value $value");
    }).onError((error, stackTrace) {
      debugPrint("error");
    });
  }

  void ontapSaleActivity({
    required String status,
    required double lat,
    required double lng,
    required int routeId,
    required int checkInId,
    required String name,
    required String date,
    required bool hasOrder,
    required String urlImage,
    required String remark,
  }) {
    debugPrint(status);
    // if (status == "todo") {
    //   Get.to(() => ReportCheckOut(
    //         routeId: routeId,
    //         lat: lat,
    //         long: lng,
    //         checkInId: checkInId,
    //         date: date,
    //         remark: remark,
    //         urlImage: urlImage,
    //         hasOrder: hasOrder,
    //       ));
    // } else if (status == "check-in") {
    //   Get.to(() => ReportCheckOut(
    //         routeId: routeId,
    //         lat: lat,
    //         long: lng,
    //         checkInId: checkInId,
    //         date: date,
    //         remark: remark,
    //         urlImage: urlImage,
    //         hasOrder: hasOrder,
    //       ));

    // } else {
    //   Get.to(() => ReportCheckOut(
    //         routeId: routeId,
    //         lat: lat,
    //         long: lng,
    //         checkInId: checkInId,
    //         date: date,
    //         remark: remark,
    //         urlImage: urlImage,
    //         hasOrder: hasOrder,
    //       ));
    //   // Get.to(() => const ReportCheckOut());
    // }
    Get.to(() => CheckOutScreen(
          routId: routeId,
          lat: lat,
          long: lng,
          checkInId: checkInId,
        ));
  }

  bool checkAvailabel(
    bool monDay,
    bool tueDay,
    bool wedDay,
    bool thuDay,
    bool friDay,
    bool satDay,
  ) {
    String day = DateFormat('EEEE').format(DateTime.now());
    if (day == "Monday" && monDay == true) {
      return true;
    }
    if (day == "Tuesday" && tueDay == true) {
      return true;
    }
    if (day == "Wednesday" && wedDay == true) {
      return true;
    }
    if (day == "Thursday" && tueDay == true) {
      return true;
    }
    if (day == "Friday" && friDay == true) {
      return true;
    }
    if (day == "Saturday" && satDay == true) {
      return true;
    }
    return false;
  }
}
