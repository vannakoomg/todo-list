import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/bottom_navigetion/controller/botton_navigetion_controller.dart';
import 'package:googlemap_ui/modules/customer/controller/customer_controller.dart';
import 'package:googlemap_ui/modules/customer/screen/customer_screen.dart';
import 'package:googlemap_ui/modules/home_screen/screen/home_screen.dart';
import 'package:googlemap_ui/modules/order/controller/order_controller.dart';
import 'package:googlemap_ui/modules/order/screens/order_screen.dart';
import 'package:googlemap_ui/modules/user_info/screens/user_info_screen.dart';

class BottomNavigetionScreen extends StatefulWidget {
  const BottomNavigetionScreen({super.key});

  @override
  State<BottomNavigetionScreen> createState() => _BottomNavigetionScreenState();
}

class _BottomNavigetionScreenState extends State<BottomNavigetionScreen> {
  final controller = Get.put(BottonNavigetionController());
  final customController = Get.put(CustomerController());
  final orderController = Get.put(OrderController());

  @override
  void initState() {
    controller.index.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: controller.index.value,
                  children: const [
                    HomeScreen(),
                    OrderScreen(),
                    CustomerScreen(),
                    UserInfoScreen(),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                border: Border(
                  top: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                )),
            height: 60,
            child: Row(
              children: [
                ...controller.icon.asMap().entries.map((e) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // debugPrint("kk ${controller.index.value}");

                        if (e.key == 2 && controller.index.value == 2) {
                          customController.scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                        if (e.key == 1 && controller.index.value == 1) {
                          orderController.scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                        controller.index.value = e.key;
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Icon(
                          e.value.icon,
                          // size: 25,
                          color: controller.index.value == e.key
                              ? AppColor.secondnaryColor
                              : Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ));
  }
}
