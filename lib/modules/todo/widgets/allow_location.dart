import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';

Future<void> allowlocaiton(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        content: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          height: 100,
          child: Column(
            children: [
              Text('Location', style: Theme.of(context).textTheme.titleMedium),
              Expanded(
                child: Center(
                  child: Text('This app need you allow the locaiton',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColor.secondnaryColor)),
          ),
          GestureDetector(
            onTap: () {
              Geolocator.openAppSettings();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              width: 40,
              height: 25,
              decoration: BoxDecoration(
                  color: AppColor.secondnaryColor,
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Text('OK',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        )),
              ),
            ),
          ),
        ],
      );
    },
  );
}
