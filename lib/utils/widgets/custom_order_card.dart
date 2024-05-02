import 'package:flutter/material.dart';

class CustomOrderCard extends StatelessWidget {
  final String title;
  final String value;
  final Function ontap;
  final Widget? icon;
  const CustomOrderCard({
    super.key,
    required this.title,
    required this.value,
    required this.ontap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
        ),
        GestureDetector(
          onTap: () {
            ontap();
          },
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.onTertiary
                // border: Border.all(
                //   width: 0.5,
                //   color: Theme.of(context).colorScheme.onSecondary,
                // ),
                ),
            height: 42,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                icon ??
                    const Icon(
                      Icons.date_range_rounded,
                      size: 19,
                      // color: AppColor.secondnaryColor,
                    )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
