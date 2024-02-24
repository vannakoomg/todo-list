import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/checkOut/controller/checkout_controller.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckOutController());
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: const CustomAppBar(title: "Check Out"),
      body: Obx(() => Container(
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Remake",
                              style: Theme.of(context).textTheme.titleSmall,
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                          onChanged: (value) {},
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
                            hintText: "Enter remake",
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
                        Text(
                          "Photo",
                          style: Theme.of(context).textTheme.titleSmall,
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
                                      borderRadius: BorderRadius.circular(10),
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
                                          color: AppColor.secondnaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image:
                                            FileImage(controller.photo.value),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Get Order",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Checkbox(
                              value: controller.ischeck.value,
                              activeColor: AppColor.successColor,
                              checkColor: Colors.white,
                              onChanged: (bool? value) {
                                controller.ischeck.value =
                                    !controller.ischeck.value;
                              },
                            ),
                          ],
                        ),
                      ]),
                ),
                CustomButtom(
                  title: "CHECK OUT",
                  onTap: () {
                    // this is the RUPP latlong
                    // openGoogleMaps(11.569500928267594, 104.89318557609106);
                  },
                  white: 130,
                )
              ],
            ),
          )),
    );
  }
}
