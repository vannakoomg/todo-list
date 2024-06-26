import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/customer/controller/customer_controller.dart';
import 'package:googlemap_ui/modules/customer/screen/create_customer_screen.dart';
import 'package:googlemap_ui/modules/todo/controller/check_in_controller.dart';
import 'package:googlemap_ui/utils/fuction.dart';
import 'package:googlemap_ui/utils/widgets/csutom_empty.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';
import 'package:googlemap_ui/utils/widgets/custom_loading.dart';

import '../../../config/const/app_colors.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final controller = Get.put(CustomerController());
  final checkinController = ChcekinController();
  // ScrollController scrollController = ScrollController();

  @override
  void initState() {
    controller.getCurrentLocation();
    controller.scrollController.addListener(() {
      if (controller.scrollController.offset ==
              controller.scrollController.position.maxScrollExtent &&
          controller.currentPage.value < controller.lastpage.value) {
        debugPrint("home ------");
        controller.currentPage.value = controller.currentPage.value + 1;
        controller.fetchCustomer(controller.currentPage.value);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppBar(
          title: "Customer",
          isLeading: false,
          action: CustomButtom(
            white: 40,
            title: "",
            onTap: () {
              Get.to(() => const CreateCustomerScreen());
            },
            icon: Icons.add_reaction_rounded,
          ),
        ),
        body: Obx(
          () => controller.isloading.value && controller.custom.isEmpty
              ? const Center(
                  child: CustomLoading(),
                )
              : controller.custom.isNotEmpty
                  ? RefreshIndicator(
                      color: AppColor.secondnaryColor,
                      onRefresh: () async {
                        controller.custom.clear();
                        controller.currentPage.value = 1;
                        controller.fetchCustomer(controller.currentPage.value);
                      },
                      child: Stack(
                        children: [
                          ListView(
                            controller: controller.scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              const Gap(5),
                              ...controller.custom.asMap().entries.map((e) {
                                return GestureDetector(
                                  onTap: () {
                                    debugPrint(
                                        "value : ${e.value.lat} ${e.value.long}");
                                    checkinController.showMapDetail(
                                        context,
                                        double.parse(e.value.lat.toString()),
                                        double.parse(e.value.long.toString()),
                                        controller.address.value);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Stack(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.all(15),
                                          margin: const EdgeInsets.only(),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 30,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${e.value.name}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                              const Gap(5),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${e.value.mobile}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSecondary),
                                                  ),
                                                  const Gap(10),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        "${e.value.email}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSecondary),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Gap(5),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_sharp,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondary,
                                                    size: 18,
                                                  ),
                                                  const Gap(5),
                                                  Text(
                                                    "${e.value.name}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSecondary),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          child: Container(
                                            height: 25,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: e.value.colorCode != ""
                                                  ? Color(int.parse(
                                                      "0xff${e.value.colorCode}"))
                                                  : Colors.red,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(40),
                                                topRight: Radius.circular(30),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                toTitleCase(
                                                    e.value.customerType),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                          if (controller.isloading.value &&
                              controller.custom.isNotEmpty)
                            Positioned(
                              bottom: 0,
                              left: MediaQuery.sizeOf(context).width / 2 - 20,
                              child: const CustomLoading(),
                            )
                        ],
                      ),
                    )
                  : Center(
                      child: GestureDetector(
                          onTap: () {
                            controller
                                .fetchCustomer(controller.currentPage.value);
                          },
                          child: const CustomEmpty()),
                    ),
        ));
  }
}
