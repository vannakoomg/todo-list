import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/home_screen/controller/home_controller.dart';
import 'package:googlemap_ui/modules/todo/screen/check_in_non_customer.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_loading.dart';
import 'package:googlemap_ui/utils/widgets/custom_oops.dart';
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
    controller.fetchSale();
    controller.getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Obx(() => Scaffold(
            appBar: CustomAppBar(
              title: "Sale Activity",
              isleading: false,
              action: GestureDetector(
                onTap: () {
                  Get.to(const CheckInNonCustomerScreen());
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: AppColor.secondnaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
            backgroundColor: AppColor.primaryColor,
            body: SafeArea(
              child: Container(
                color: Theme.of(context).colorScheme.secondary,
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            child: controller.isloading.value
                                ? const Center(
                                    child: CustomLoading(),
                                  )
                                : Container(
                                    // margin: const EdgeInsets.only(top: 20),
                                    padding: const EdgeInsets.only(
                                        // left: 10,
                                        // right: 10,
                                        // bottom: 10,
                                        ),
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        controller.fetchSale();
                                      },
                                      color: AppColor.secondnaryColor,
                                      triggerMode:
                                          RefreshIndicatorTriggerMode.anywhere,
                                      displacement: 40,
                                      child:
                                          controller.saleData.value.data != null
                                              ? controller.saleData.value.data!
                                                      .isNotEmpty
                                                  ? ListView.builder(
                                                      itemCount: controller
                                                          .saleData
                                                          .value
                                                          .data!
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                // Text(
                                                                //     "${controller.saleData.value.data![index].id}"),
                                                                Expanded(
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      controller
                                                                          .indexOfSale
                                                                          .value = index;
                                                                      double photoLat = controller.saleData.value.data![index].photoLat ==
                                                                              ""
                                                                          ? 0
                                                                          : double.parse(controller
                                                                              .saleData
                                                                              .value
                                                                              .data![index]
                                                                              .photoLat!);
                                                                      double photoLong = controller.saleData.value.data![index].photoLong ==
                                                                              ""
                                                                          ? 0
                                                                          : double.parse(controller
                                                                              .saleData
                                                                              .value
                                                                              .data![index]
                                                                              .photoLong!);
                                                                      controller.ontapSaleActivity(
                                                                          photolong:
                                                                              photoLong,
                                                                          photoLat:
                                                                              photoLat,
                                                                          date:
                                                                              "${controller.saleData.value.data![index].checkOutDate}",
                                                                          hasOrder: controller.saleData.value.data![index].hasOrder ??
                                                                              false,
                                                                          remark:
                                                                              "${controller.saleData.value.data![index].remark}",
                                                                          urlImage:
                                                                              "${controller.saleData.value.data![index].photo}",
                                                                          checkInId: controller.saleData.value.data![index].id ??
                                                                              0,
                                                                          name:
                                                                              "${controller.saleData.value.data![index].customerName}",
                                                                          lat: controller.saleData.value.data![index].lat ??
                                                                              0.0,
                                                                          lng: controller.saleData.value.data![index].long ??
                                                                              0.0,
                                                                          status:
                                                                              "${controller.saleData.value.data![index].status}");
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      margin: const EdgeInsets
                                                                          .only(
                                                                        top: 10,
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10,
                                                                      ),
                                                                      child:
                                                                          CustomTodoCard(
                                                                        name: controller.saleData.value.data![index].customerName ??
                                                                            "",
                                                                        stuts: controller.saleData.value.data![index].status ??
                                                                            "",
                                                                        customer:
                                                                            controller.saleData.value.data![index].customerName ??
                                                                                "",
                                                                        address:
                                                                            controller.saleData.value.data![index].address ??
                                                                                "",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    )
                                                  : SizedBox(
                                                      // color: Colors.red,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height +
                                                          4000,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Icon(
                                                            Icons.grade_rounded,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    247,
                                                                    218,
                                                                    0),
                                                            size: 50,
                                                          ),
                                                          Text(
                                                            "No task for you now.",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onSecondary,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                              : CustomOops(
                                                  ontap: () {
                                                    controller.fetchSale();
                                                  },
                                                ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
