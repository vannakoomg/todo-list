import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/login/controller/login_controller.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';
import 'package:googlemap_ui/utils/widgets/custom_texfiled.dart';

import '../../../config/const/app_colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Obx(
          () => SafeArea(
              child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("images/logo.png"),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Sale Activity",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
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
                                style: Theme.of(context).textTheme.bodyMedium!,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextfiled(
                                controller: controller.userNameText.value,
                                hintText: "Enter User Name",
                                onChanged: (value) {
                                  controller.userName.value = value;
                                },
                                suffixIcon: const Icon(Icons.person),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Password",
                                style: Theme.of(context).textTheme.bodyMedium!,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextfiled(
                                controller: controller.passWordText.value,
                                hintText: "Enter Password",
                                onChanged: (value) {
                                  controller.passWord.value = value;
                                },
                                suffixIcon: const Icon(Icons.remove_red_eye),
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
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
