import 'package:flutter/material.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/utils/widgets/custom_back.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget action;
  final Widget leading;
  final bool isleading;
  const CustomAppBar(
      {super.key,
      this.action = const SizedBox(),
      required this.title,
      this.isleading = true,
      this.leading = const CustomBack()});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0), // Adjust the height as needed
      child: AppBar(
        leadingWidth: 40,
        leading: isleading == true ? leading : const SizedBox(),
        backgroundColor: AppColor.secondnaryColor,
        centerTitle: true,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
        actions: [action],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
