import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/utils/fuction.dart';

class CustomBack extends StatelessWidget {
  final Function? ontap;
  const CustomBack({super.key, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap == null
          ? () {
              unFocus(context);
              Get.back();
            }
          : () {
              ontap!();
            },
      child: Icon(
        Platform.isAndroid
            ? Icons.arrow_back_rounded
            : Icons.arrow_back_ios_new_rounded,
        color: Theme.of(context).colorScheme.primary,
        size: 26,
      ),
    );
  }
}
