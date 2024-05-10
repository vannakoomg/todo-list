import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/utils/fuction.dart';

class CustomTodoCard extends StatelessWidget {
  final String name;
  final String stuts;
  final String customer;
  final String address;
  const CustomTodoCard(
      {super.key,
      required this.stuts,
      required this.customer,
      required this.name,
      required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            blurRadius: 18,
            spreadRadius: 0.1,
          ),
        ],
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall),
                Text(
                  customer,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_sharp,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 18,
                    ),
                    const Gap(5),
                    Text(
                      address == "" ? "NA" : address,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: stuts == "todo"
                  ? const Color.fromARGB(255, 137, 137, 137)
                  : stuts == "check-in"
                      ? const Color.fromARGB(255, 72, 141, 197)
                      : stuts == "check-out"
                          ? const Color.fromARGB(255, 193, 148, 82)
                          : AppColor.success,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              toTitleCase(stuts),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
