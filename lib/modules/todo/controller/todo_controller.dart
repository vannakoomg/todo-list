import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/todo/screen/map_detail.dart';

class TodoController extends GetxController {
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
