import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';

import '../context_unitity.dart';

class CustomDialog {
  static error({
    bool barrierDismissible = true,
    required String title,
    required String message,
    String bottonTitle = "Continue",
    Function? ontap,
  }) {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: ContextUtility.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          elevation: 0.0,
          content: IntrinsicHeight(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 30, left: 20, right: 20, bottom: 30),
                    child: Column(
                      children: [
                        Icon(
                          Icons.dangerous_rounded,
                          color: AppColor.danger,
                          size: 70,
                          weight: 100,
                        ),
                        const Gap(10),
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: const Color.fromARGB(255, 147, 56, 49),
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color:
                                      const Color.fromARGB(255, 162, 85, 79)),
                        ),
                        const Gap(20),
                        CustomButtom(
                          height: 30,
                          white: 100,
                          fountSize: 14,
                          colors: AppColor.danger,
                          title: bottonTitle,
                          radius: 30,
                          onTap: () {
                            if (ontap == null) {
                              Navigator.pop(context);
                            } else {
                              ontap();
                            }
                          },
                          outline: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static success({
    bool barrierDismissible = true,
    required String title,
    required String message,
    String bottonTitle = "Continue",
    Function? ontap,
  }) {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: ContextUtility.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          elevation: 0.0,
          content: IntrinsicHeight(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 30, left: 20, right: 20, bottom: 30),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppColor.success),
                          child: const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 30,
                            weight: 100,
                          ),
                        ),
                        const Gap(10),
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: const Color.fromARGB(255, 0, 94, 2),
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: const Color.fromARGB(255, 0, 94, 2),
                                  ),
                        ),
                        const Gap(20),
                        CustomButtom(
                          height: 30,
                          white: 100,
                          fountSize: 14,
                          colors: AppColor.success,
                          title: bottonTitle,
                          radius: 30,
                          onTap: () {
                            if (ontap == null) {
                              Navigator.pop(context);
                            } else {
                              ontap();
                            }
                          },
                          outline: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static warning({
    bool barrierDismissible = true,
    required String title,
    required String message,
    String bottonTitle = "Continue",
    Function? ontap,
  }) {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: ContextUtility.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          elevation: 0.0,
          content: IntrinsicHeight(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 30, left: 20, right: 20, bottom: 30),
                    child: Column(
                      children: [
                        Icon(
                          Icons.warning_rounded,
                          color: AppColor.warning,
                          size: 70,
                          weight: 100,
                        ),
                        const Gap(10),
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      const Color.fromARGB(255, 203, 141, 47),
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: const Color.fromARGB(255, 198, 150, 78),
                              ),
                        ),
                        const Gap(20),
                        CustomButtom(
                          height: 30,
                          white: 100,
                          fountSize: 14,
                          colors: AppColor.warning,
                          title: bottonTitle,
                          radius: 30,
                          onTap: () {
                            if (ontap == null) {
                              Navigator.pop(context);
                            } else {
                              ontap();
                            }
                          },
                          outline: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static info({
    bool barrierDismissible = true,
    required String title,
    required String message,
    String bottonTitle = "Contiune",
    Function? ontap,
  }) {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      barrierDismissible: barrierDismissible,
      context: ContextUtility.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          elevation: 0.0,
          content: IntrinsicHeight(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 30, left: 20, right: 20, bottom: 30),
                    child: Column(
                      children: [
                        Icon(
                          Icons.info_rounded,
                          color: AppColor.info,
                          size: 70,
                          weight: 100,
                        ),
                        const Gap(10),
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: const Color.fromARGB(255, 14, 96, 162),
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color:
                                      const Color.fromARGB(255, 25, 117, 192)),
                        ),
                        const Gap(20),
                        CustomButtom(
                          height: 30,
                          white: 100,
                          fountSize: 14,
                          colors: AppColor.info,
                          title: bottonTitle,
                          radius: 30,
                          onTap: () {
                            if (ontap == null) {
                              Navigator.pop(context);
                            } else {
                              ontap();
                            }
                          },
                          outline: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
