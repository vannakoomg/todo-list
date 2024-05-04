import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/home_screen/controller/activity_controller.dart';
import 'package:googlemap_ui/utils/fuction.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_loading.dart';

class ReportCheckOut extends StatefulWidget {
  final int id;
  const ReportCheckOut({super.key, required this.id});

  @override
  State<ReportCheckOut> createState() => _ReportCheckOutState();
}

class _ReportCheckOutState extends State<ReportCheckOut> {
  final controller = ActivityController();
  @override
  void initState() {
    controller.isloading.value = true;
    Future.delayed(const Duration(milliseconds: 100), () {
      controller.fetchActivityDetail(widget.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppBar(title: "Activity Detail"),
      body: Obx(
        () => Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onTertiary,
            borderRadius: BorderRadius.circular(10),
          ),
          margin:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: controller.isloading.value
              ? const Center(child: CustomLoading())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date",
                              style: Theme.of(context).textTheme.titleSmall!,
                            ),
                            Text(
                              "${controller.activity.value.checkOutDate}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Remark",
                              style: Theme.of(context).textTheme.titleSmall!,
                            ),

                            Text(
                              "${controller.activity.value.remark}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),

                            // CustomTextfiled(
                            //   controller: controller.remarkText.value,
                            //   hintText: "Enter Remark",
                            //   onChanged: (value) {
                            //     controller.remark.value = value;
                            //   },
                            //   maxLines: 5,
                            // ),
                            // Row(
                            //   children: [
                            //     Text(
                            //       "Has Order",
                            //       style: Theme.of(context).textTheme.titleSmall,
                            //     ),
                            //     Checkbox(
                            //       value: controller.activity.value.hasOrder,
                            //       activeColor: AppColor.success,
                            //       checkColor: Colors.white,
                            //       onChanged: (value) {},
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: MediaQuery.sizeOf(context).width / 1.8,
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.4,
                                    color: AppColor.secondnaryColor,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  image: DecorationImage(
                                    image: imageFromBase64String(
                                      "${controller.activity.value.photo}",
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${controller.activity.value.photoLat}, ${controller.activity.value.photoLong}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    openGoogleMap(
                                      lat: double.parse(
                                          "${controller.activity.value.photoLat}"),
                                      lng: double.parse(
                                          "${controller.activity.value.photoLong}"),
                                      context: context,
                                      title: "",
                                    );
                                  },
                                  child: Text(
                                    "View Map",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: AppColor.secondnaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(bottom: 10, top: 10),
                    //   child: CustomButtom(
                    //     white: double.infinity,
                    //     disble: controller.validateUpdate(),
                    //     title: "UPDATE",
                    //     onTap: () {},
                    //   ),
                    // ),
                  ],
                ),
        ),
      ),
    );
  }
}
