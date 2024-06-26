import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/checkOut/controller/checkout_controller.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';
import 'package:googlemap_ui/utils/widgets/custom_loading.dart';
import 'package:googlemap_ui/utils/widgets/custom_texfiled.dart';

import '../../../utils/fuction.dart';

class CheckOutScreen extends StatefulWidget {
  final double lat;
  final double long;
  final int checkInId;
  const CheckOutScreen({
    super.key,
    required this.lat,
    required this.long,
    required this.checkInId,
  });

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final controller = Get.put(CheckOutController());

  @override
  void initState() {
    checkPermission(context);
    controller.getCurrentLocation();
    controller.shoplat.value = widget.lat;
    controller.shoplong.value = widget.long;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar: const CustomAppBar(title: "Check Out"),
              body: Container(
                margin: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 10),
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
                                        .copyWith(color: AppColor.danger),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextfiled(
                                controller: controller.remarkText.value,
                                hintText: "Enter remark",
                                onChanged: (value) {
                                  controller.remark.value = value;
                                },
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
                                        .copyWith(color: AppColor.danger),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.takePhoto(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: controller.photo.value.path == ""
                                      ? Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          height:
                                              MediaQuery.sizeOf(context).width /
                                                  1.8,
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            border: Border.all(
                                                color:
                                                    AppColor.secondnaryColor),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                              image: FileImage(
                                                  controller.photo.value),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              // Row(
                              //   children: [
                              //     Text(
                              //       "Has Order",
                              //       style:
                              //           Theme.of(context).textTheme.titleSmall,
                              //     ),
                              //     Checkbox(
                              //       value: controller.hasOrder.value,
                              //       activeColor: AppColor.successColor,
                              //       checkColor: Colors.white,
                              //       onChanged: (bool? value) {
                              //         controller.hasOrder.value =
                              //             !controller.hasOrder.value;
                              //       },
                              //     ),
                              //   ],
                              // ),
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
                          checkInId: widget.checkInId,
                          context: context,
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
