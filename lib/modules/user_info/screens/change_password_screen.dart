import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/user_info/controller/user_info_controller.dart';
import 'package:googlemap_ui/utils/widgets/custom_appBar_widget.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';
import 'package:googlemap_ui/utils/widgets/custom_loading.dart';
import 'package:googlemap_ui/utils/widgets/custom_texfiled.dart';

import '../../../utils/fuction.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final controller = UserInfoContorller();

  @override
  void initState() {
    controller.fetchOldPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          const Gap(10),
          CustomAppBarWidget(
            title: "Change Password",
            ontap: () {
              Get.back();
            },
            isClose: true,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Old Password",
                //   style: Theme.of(context).textTheme.bodyMedium,
                // ),
                // const Gap(10),
                // CustomTextfiled(
                //   controller: controller.oldPasswordText.value,
                //   hintText: "",
                //   borderColor:
                //       controller.old.value == controller.oldPassword.value
                //           ? AppColor.successColor
                //           : null,
                //   onChanged: (value) {
                //     controller.oldPassword.value = value;
                //   },
                // ),
                // const Gap(20),
                Text(
                  "New Password",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Gap(10),
                CustomTextfiled(
                  autofocus: true,
                  controller: controller.newPasswordText.value,
                  hintText: "",
                  onChanged: (value) {
                    controller.newPassword.value = value;
                  },
                ),
                const Gap(20),
                controller.isLoaing.value
                    ? Center(
                        child: CustomLoading(
                          colors: AppColor.success,
                        ),
                      )
                    : CustomButtom(
                        white: double.infinity,
                        disble: controller.newPassword.value.length > 3
                            ? false
                            : true,
                        title: "OK",
                        colors: AppColor.success,
                        onTap: () {
                          unFocus();
                          controller.changePassword();
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
