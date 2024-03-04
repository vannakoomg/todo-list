import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/home_screen/controller/home_controller.dart';
import 'package:googlemap_ui/utils/widgets/custom_todo_card.dart';

import '../../../utils/fuction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(HomeController());

  @override
  void initState() {
    requestPermission();
    // controller.checkAvailabel();
    controller.fetchSale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Obx(() => Scaffold(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            body: SafeArea(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 30,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              controller.date.value == ""
                                  ? "Sale Activity"
                                  : controller.date.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColor.secondnaryColor,
                                  ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   top: 4,
                        //   right: 10,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       controller.selectDate(context);
                        //     },
                        //     child: Icon(
                        //       Icons.calendar_month_rounded,
                        //       size: 22,
                        //       color: AppColor.secondnaryColor,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 0.5,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            controller.isloading.value
                                ? Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 10, top: 10),
                                    height: 60,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                          color: AppColor.secondnaryColor),
                                    ),
                                  )
                                : Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                        child: RefreshIndicator(
                                          onRefresh: () async {
                                            controller.fetchSale();
                                          },
                                          color: AppColor.secondnaryColor,
                                          triggerMode:
                                              RefreshIndicatorTriggerMode
                                                  .anywhere,
                                          displacement: 40,
                                          child: ListView.builder(
                                            itemCount: controller
                                                .saleData.value.data!.length,
                                            itemBuilder: (context, index) {
                                              controller.indexOfSale = index;
                                              return controller.checkAvailabel(
                                                          controller
                                                              .saleData
                                                              .value
                                                              .data![index]
                                                              .monDay!,
                                                          controller
                                                              .saleData
                                                              .value
                                                              .data![index]
                                                              .monDay!,
                                                          controller
                                                              .saleData
                                                              .value
                                                              .data![index]
                                                              .monDay!,
                                                          controller
                                                              .saleData
                                                              .value
                                                              .data![index]
                                                              .monDay!,
                                                          controller
                                                              .saleData
                                                              .value
                                                              .data![index]
                                                              .monDay!,
                                                          controller
                                                              .saleData
                                                              .value
                                                              .data![index]
                                                              .monDay!) ==
                                                      true
                                                  ? GestureDetector(
                                                      onTap: () async {
                                                        controller.ontapSaleActivity(
                                                            date: "03/03/2024",
                                                            hasOrder: true,
                                                            remark:
                                                                "sadfdsaffdsdaf",
                                                            urlImage:
                                                                "https://c8.alamy.com/comp/2JMFP60/fancy-party-college-reunion-happy-hugging-girls-2JMFP60.jpg",
                                                            routeId: controller
                                                                .saleData
                                                                .value
                                                                .data![index]
                                                                .id!,
                                                            checkInId: controller
                                                                    .saleData
                                                                    .value
                                                                    .data![
                                                                        index]
                                                                    .checkInId ??
                                                                0,
                                                            name:
                                                                "${controller.saleData.value.data![index].name}",
                                                            lat: controller
                                                                    .saleData
                                                                    .value
                                                                    .data![
                                                                        index]
                                                                    .customer!
                                                                    .late ??
                                                                0.0,
                                                            lng: controller
                                                                    .saleData
                                                                    .value
                                                                    .data![
                                                                        index]
                                                                    .customer!
                                                                    .long ??
                                                                0.0,
                                                            status:
                                                                "${controller.saleData.value.data![index].status}");
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                          bottom: 10,
                                                        ),
                                                        child: CustomTodoCard(
                                                          name: controller
                                                                  .saleData
                                                                  .value
                                                                  .data![index]
                                                                  .name ??
                                                              "",
                                                          stuts: controller
                                                                  .saleData
                                                                  .value
                                                                  .data![index]
                                                                  .status ??
                                                              "",
                                                          customer: controller
                                                                  .saleData
                                                                  .value
                                                                  .data![index]
                                                                  .customer!
                                                                  .name ??
                                                              "",
                                                          address: controller
                                                                  .saleData
                                                                  .value
                                                                  .data![index]
                                                                  .customer!
                                                                  .address ??
                                                              "",
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox();
                                            },
                                          ),
                                        )),
                                  ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
