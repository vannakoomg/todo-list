import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';

Future<void> allowlocaiton(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        content: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          height: 150,
          child: Column(
            children: [
              Text('Location', style: Theme.of(context).textTheme.titleMedium),
              Expanded(
                child: Center(
                  child: Text('This app need you allow the locaiton!',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          )),
                ),
              ),
              CustomButtom(
                title: "OK",
                height: 30,
                white: 50,
                onTap: () {
                  Get.back();
                  Geolocator.openAppSettings();
                },
              )
            ],
          ),
        ),
        actions: const [],
      );
    },
  );
}
