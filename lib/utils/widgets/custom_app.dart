import 'package:flutter/material.dart';
import 'package:googlemap_ui/utils/widgets/custom_back.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget action;
  final Widget leading;
  const CustomAppBar(
      {super.key,
      this.action = const SizedBox(),
      required this.title,
      this.leading = const CustomBack()});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0), // Adjust the height as needed
      child: AppBar(
        leadingWidth: 40,
        leading: leading,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        centerTitle: true,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [action],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
