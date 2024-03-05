import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/home_screen/controller/home_controller.dart';
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
    // controller.checkAvailabel();
    controller.fetchSale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Obx(() => Scaffold(
            appBar: const CustomAppBar(
              title: "Sale Activity",
              isleading: false,
            ),
            backgroundColor: AppColor.secondnaryColor,
            body: SafeArea(
              child: Container(
                color: Theme.of(context).colorScheme.secondary,
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: controller.isloading.value
                          ? const Center(
                              child: CustomLoading(),
                            )
                          : Container(
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  controller.fetchSale();
                                },
                                color: AppColor.secondnaryColor,
                                triggerMode:
                                    RefreshIndicatorTriggerMode.anywhere,
                                displacement: 40,
                                child: controller.saleData.value.data != null
                                    ? controller.saleData.value.data!.isNotEmpty
                                        ? ListView.builder(
                                            itemCount: controller
                                                .saleData.value.data!.length,
                                            itemBuilder: (context, index) {
                                              controller.indexOfSale = index;
                                              return GestureDetector(
                                                onTap: () async {
                                                  controller.ontapSaleActivity(
                                                      photolong: double.parse(
                                                          controller
                                                              .saleData
                                                              .value
                                                              .data![index]
                                                              .photoLong!),
                                                      photoLat: double.parse(
                                                          controller
                                                              .saleData
                                                              .value
                                                              .data![index]
                                                              .photoLat!),
                                                      date:
                                                          "${controller.saleData.value.data![index].checkOutDate}",
                                                      hasOrder: controller
                                                              .saleData
                                                              .value
                                                              .data![index]
                                                              .hasOrder ??
                                                          false,
                                                      remark:
                                                          "${controller.saleData.value.data![index].remark}",
                                                      urlImage:
                                                          "https://c8.alamy.com/comp/2JMFP60/fancy-party-college-reunion-happy-hugging-girls-2JMFP60.jpg",
                                                      checkInId: controller
                                                              .saleData
                                                              .value
                                                              .data![index]
                                                              .id ??
                                                          0,
                                                      name:
                                                          "${controller.saleData.value.data![index].customerName}",
                                                      lat: controller
                                                              .saleData
                                                              .value
                                                              .data![index]
                                                              .lat ??
                                                          0.0,
                                                      lng: controller.saleData.value.data![index].long ?? 0.0,
                                                      status: "${controller.saleData.value.data![index].status}");
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                    bottom: 10,
                                                  ),
                                                  child: CustomTodoCard(
                                                    name: controller
                                                            .saleData
                                                            .value
                                                            .data![index]
                                                            .customerName ??
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
                                                            .customerName ??
                                                        "",
                                                    address: controller
                                                            .saleData
                                                            .value
                                                            .data![index]
                                                            .address ??
                                                        "",
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : SizedBox(
                                            // color: Colors.red,
                                            height: MediaQuery.sizeOf(context)
                                                    .height +
                                                4000,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.grade_rounded,
                                                  color: Color.fromARGB(
                                                      255, 247, 218, 0),
                                                  size: 50,
                                                ),
                                                Text(
                                                  "There are no task for you\n today.",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        color: Theme.of(context)
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
            ),
          )),
    );
  }
}
