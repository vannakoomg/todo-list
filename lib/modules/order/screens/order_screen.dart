import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/order/controller/create_order_controller.dart';
import 'package:googlemap_ui/modules/order/controller/order_controller.dart';
import 'package:googlemap_ui/modules/order/screens/create_order_screen.dart';
import 'package:googlemap_ui/modules/order/screens/order_detail_screen.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';
import 'package:googlemap_ui/utils/widgets/custom_loading.dart';
import 'package:googlemap_ui/utils/widgets/custom_order_history.dart';
import 'package:sizer/sizer.dart';

import '../../../config/const/app_colors.dart';
import '../../../utils/widgets/custom_oops.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final controller = Get.put(OrderController());
  final orderDetailController = Get.put(CreateOrderController());
  // ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // controller.fetchSaleOrder();
    controller.fetchSaleOrder(controller.currentPage.value);
    controller.scrollController.addListener(() {
      if (controller.scrollController.offset ==
              controller.scrollController.position.maxScrollExtent &&
          controller.currentPage.value < controller.lastpage.value) {
        debugPrint("max ");
        controller.currentPage.value += 1;
        controller.fetchSaleOrder(controller.currentPage.value);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        isLeading: false,
        title: "Order",
        action: CustomButtom(
          white: 40,
          title: "",
          onTap: () {
            Get.to(() => const CreateOrderScreem());
          },
          icon: Icons.add_shopping_cart_rounded,
        ),
      ),
      body: Obx(() => controller.isloading.value && controller.order.isEmpty
          ? const Center(
              child: CustomLoading(),
            )
          : controller.order.isNotEmpty
              ? Stack(
                  children: [
                    Container(
                      child: SizerUtil.deviceType == DeviceType.tablet
                          ? RefreshIndicator(
                              color: AppColor.secondnaryColor,
                              onRefresh: () async {
                                controller.order.clear();
                                controller.currentPage.value = 0;
                                controller.fetchSaleOrder(
                                    controller.currentPage.value);
                              },
                              child: GridView.count(
                                physics: const AlwaysScrollableScrollPhysics(),
                                crossAxisSpacing: 5,
                                crossAxisCount: 2,
                                childAspectRatio: 1.2,
                                controller: controller.scrollController,
                                children: [
                                  ...controller.order.asMap().entries.map((e) {
                                    return CustomOrderhistory(
                                      ontap: () {
                                        orderDetailController
                                                .orderIndex.value ==
                                            e.key;

                                        Get.to(() => OrderDetailScreen(
                                              id: e.value.id!,
                                              status: "${e.value.status}",
                                            ));
                                      },
                                      status: "${e.value.status}",
                                      price: "${e.value.amount}",
                                      name: "${e.value.partnerName}",
                                      deliverAddress:
                                          "${e.value.deliveryAddress}",
                                      deliveryDate: "${e.value.deliveryDate}",
                                      orderDate: "${e.value.dateOrder}",
                                    );
                                  })
                                ],
                              ),
                            )
                          : RefreshIndicator(
                              color: AppColor.secondnaryColor,
                              onRefresh: () async {
                                controller.order.clear();
                                controller.currentPage.value = 0;
                                controller.fetchSaleOrder(
                                    controller.currentPage.value);
                              },
                              child: ListView(
                                controller: controller.scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: [
                                  ...controller.order.asMap().entries.map((e) {
                                    return CustomOrderhistory(
                                      ontap: () {
                                        orderDetailController
                                                .orderIndex.value ==
                                            e.key;
                                        Get.to(() => OrderDetailScreen(
                                              id: e.value.id!,
                                              status: "${e.value.status}",
                                            ));
                                      },
                                      status: "${e.value.status}",
                                      price: "${e.value.amount}",
                                      name: "${e.value.partnerName}",
                                      deliverAddress:
                                          "${e.value.deliveryAddress}",
                                      deliveryDate: "${e.value.deliveryDate}",
                                      orderDate: "${e.value.dateOrder}",
                                    );
                                  })
                                ],
                              ),
                            ),
                    ),
                    if (controller.isloading.value &&
                        controller.order.isNotEmpty)
                      Positioned(
                        bottom: 0,
                        left: MediaQuery.sizeOf(context).width / 2 - 20,
                        child: const CustomLoading(),
                      )
                  ],
                )
              : CustomOops(ontap: () {
                  controller.fetchSaleOrder(controller.currentPage.value);
                })),
    );
  }
}
