import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/select_url/controller/select_url_controller.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';
import 'package:googlemap_ui/utils/widgets/custom_texfiled.dart';

class SelectUrlScreen extends StatelessWidget {
  const SelectUrlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectUrlController());
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Obx(() => SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/logo.png",
                    height: 125,
                    width: 125,
                  ),
                  const Gap(30),
                  CustomTextfiled(
                    onChanged: (value) {
                      controller.url.value = value;
                    },
                    controller: controller.urlText.value,
                    hintText: "Enter Url",
                  ),
                  const Gap(20),
                  CustomButtom(
                    disble: controller.url.value == "" ? true : false,
                    white: double.infinity,
                    title: "NEXT",
                    onTap: () {
                      controller.submitUrl();
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
