import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/todo/screen/map_detail.dart';

class TodoController extends GetxController {
  final currentlat = 0.0.obs;
  final currentlng = 0.0.obs;
  void getCurrentLocation() async {
    Position location = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentlat.value = location.latitude;
    currentlng.value = location.longitude;
    debugPrint(" currentlat : ${currentlat.value}");
    debugPrint(" currentlng : ${currentlng.value}");
  }

  void showMapDetail(BuildContext context) {
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
            child: const MapDetail());
      },
    );
  }
}
