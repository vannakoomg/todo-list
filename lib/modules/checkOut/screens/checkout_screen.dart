import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/checkOut/controller/checkout_controller.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';
import 'package:googlemap_ui/utils/widgets/custom_loading.dart';

class CheckOutScreen extends StatelessWidget {
  final double lat;
  final double long;
  final int routId;
  final int checkInId;
  const CheckOutScreen({
    super.key,
    required this.lat,
    required this.long,
    required this.routId,
    required this.checkInId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckOutController());
    return Obx(() => Stack(
          children: [
            Scaffold(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              appBar: const CustomAppBar(title: "Check Out"),
              body: Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Remark",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    " *",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: AppColor.dangerColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: controller.remarkText.value,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                onChanged: (value) {
                                  controller.remark.value = value;
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColor.secondnaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: AppColor.secondnaryColor,
                                    ),
                                  ),
                                  hintText: "Enter remark",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                ),
                                maxLines: 5,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Photo",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    " *",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: AppColor.dangerColor),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.takePhoto();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: controller.photo.value.path == ""
                                      ? Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: AppColor.secondnaryColor,
                                            ),
                                          ),
                                          child: Center(
                                              child: Text(
                                            "Take Photo",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary),
                                          )),
                                        )
                                      : Container(
                                          padding: const EdgeInsets.all(5),
                                          height: 140,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            border: Border.all(
                                                color:
                                                    AppColor.secondnaryColor),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: FileImage(
                                                  controller.photo.value),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Have Order",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Checkbox(
                                    value: controller.hasOrder.value,
                                    activeColor: AppColor.successColor,
                                    checkColor: Colors.white,
                                    onChanged: (bool? value) {
                                      controller.hasOrder.value =
                                          !controller.hasOrder.value;
                                    },
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButtom(
                      disble: controller.remark.value == "" ||
                              controller.photo.value.path == ""
                          ? true
                          : false,
                      title: "CHECK OUT",
                      onTap: () {
                        controller.checkOut(
                          checkInId: checkInId,
                          lat: lat,
                          long: long,
                          routeId: routId,
                        );
                      },
                      white: 130,
                    )
                  ],
                ),
              ),
            ),
            if (controller.isloading.value)
              Container(
                color: Colors.black.withOpacity(0.4),
                height: double.infinity,
                width: double.infinity,
                child: const Center(child: CustomLoading()),
              )
          ],
        ));
  }
}
