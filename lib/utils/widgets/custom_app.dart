import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/utils/widgets/custom_back.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget action;
  final Widget leading;
  final bool isLeading;
  final bool isClose;
  const CustomAppBar(
      {super.key,
      this.action = const SizedBox(),
      this.isLeading = true,
      required this.title,
      this.isClose = false,
      this.leading = const CustomBack()});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40.0), // Adjust the height as needed
      child: AppBar(
        leadingWidth: 50,
        automaticallyImplyLeading: false,
        leading: isLeading == true
            ? isClose
                ? GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.close_rounded))
                : leading
            : null,
        backgroundColor: Theme.of(context).colorScheme.background,
        // centerTitle: true,
        title: Text(title, style: Theme.of(context).textTheme.titleLarge!
            // .copyWith(color: Theme.of(context).colorScheme.tertiary),
            ),
        actions: [
          Container(margin: const EdgeInsets.only(right: 10), child: action)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
