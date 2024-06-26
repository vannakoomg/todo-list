import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/customer/controller/customer_controller.dart';
import 'package:googlemap_ui/modules/home_screen/controller/home_controller.dart';
import 'package:googlemap_ui/modules/order/controller/order_controller.dart';
import 'package:googlemap_ui/modules/select_url/screens/select_url.dart';
import 'package:googlemap_ui/modules/user_info/screens/change_password_screen.dart';
import 'package:googlemap_ui/utils/widgets/custom_alert.dart';
import 'package:googlemap_ui/utils/widgets/custom_image_base64.dart';
import 'package:googlemap_ui/utils/widgets/custom_loading.dart';
import 'package:googlemap_ui/utils/widgets/custom_oops.dart';

import '../../../helpers/local_storage.dart';
import '../../login/screen/login_screen.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final controller = Get.put(HomeController());
  final custommerController = Get.put(CustomerController());
  final ordercontroller = Get.put(OrderController());

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      controller.fetchUserInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isloading.value
        ? const Center(
            child: CustomLoading(),
          )
        : controller.userInfo.value.data == null
            ? CustomOops(ontap: () {
                controller.fetchUserInfo();
              })
            : Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.only(top: 40, bottom: 0),
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.link),
                          onPressed: () async {
                            String url = await LocalStorage.getStringValue(
                                key: "baseUrl");
                            CustomDialog.info(
                              title: url,
                              message: "'",
                            );
                          },
                        ),
                      ),
                      CustomImageBase64(
                        height: MediaQuery.sizeOf(context).width / 3.5,
                        width: MediaQuery.sizeOf(context).width / 3.5,
                        image: "${controller.userInfo.value.data!.image}",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${controller.userInfo.value.data!.name}",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 26,
                                  // color: Colors.black,
                                ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            useSafeArea: true,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return const ChangePasswordScreen();
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 20),
                          margin: const EdgeInsets.only(
                              bottom: 10, right: 20, left: 20),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
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
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.key),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Change Password",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          int m = await LocalStorage.getIntValue(key: "mode");
                          debugPrint("mode $m");

                          if (m == 1) {
                            LocalStorage.storeData(key: "mode", value: 0);
                          } else {
                            LocalStorage.storeData(key: "mode", value: 1);
                          }
                          m = await LocalStorage.getIntValue(key: "mode");

                          final controller = Get.put(HomeController());
                          controller.mode.value = m;
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 20),
                          margin: const EdgeInsets.only(
                              bottom: 10, right: 20, left: 20),
                          height: 50,
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
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                controller.mode.value == 1
                                    ? Icons.nightlight_round
                                    : Icons.light_mode,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Mode",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          custommerController.custom.clear();
                          ordercontroller.order.clear();
                          await LocalStorage.storeData(
                              key: "access_token", value: "");
                          String name =
                              await LocalStorage.getStringValue(key: "email");
                          Get.offAll(() => const SelectUrlScreen());
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          margin: const EdgeInsets.only(right: 20, left: 20),
                          height: 50,
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
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.output,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Logout",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(20)
                    ],
                  ),
                ),
              ));
  }
}
