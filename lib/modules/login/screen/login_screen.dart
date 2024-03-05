import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/login/controller/login_controller.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';

import '../../../config/const/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Obx(
          () => SafeArea(
              child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sale Activity",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 32,
                              color: AppColor.secondnaryColor,
                            ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User Name",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          TextFormField(
                            controller: controller.userNameText.value,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                            onChanged: (value) {
                              controller.userName.value = value;
                            },
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
                              hintText: "Enter User Name",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Password",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          TextFormField(
                            controller: controller.passWordText.value,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                            onChanged: (value) {
                              controller.passWord.value = value;
                            },
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
                              hintText: "Enter Password",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      controller.isloading.value
                          ? CircularProgressIndicator(
                              color: AppColor.secondnaryColor,
                            )
                          : CustomButtom(
                              disble: controller.userName.value == "" ||
                                      controller.passWord.value == ""
                                  ? true
                                  : false,
                              white: double.infinity,
                              title: "LOGIN",
                              onTap: () {
                                controller.login(context);
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
