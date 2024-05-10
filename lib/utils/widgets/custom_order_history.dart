import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:googlemap_ui/utils/fuction.dart';
import 'package:sizer/sizer.dart';

class CustomOrderhistory extends StatelessWidget {
  final String name;
  final String price;
  final String status;
  final Function ontap;
  final String deliverAddress;
  final String orderDate;
  final String deliveryDate;
  const CustomOrderhistory({
    super.key,
    required this.name,
    required this.status,
    required this.price,
    required this.deliverAddress,
    required this.orderDate,
    required this.deliveryDate,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 0.8,
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "$price\$",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    Text(orderDate,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            )),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.onPrimary),
                      height: 5,
                      width: 5,
                    ),
                    Text(
                      deliveryDate,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: 18,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    const Gap(5),
                    Expanded(
                      child: Text(
                        deliverAddress,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                      ),
                    ),
                    if (SizerUtil.deviceType != DeviceType.tablet)
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: status == "Quotation"
                              ? const Color.fromARGB(255, 199, 198, 198)
                              : status == "Quotation Sent"
                                  ? const Color.fromARGB(255, 113, 187, 247)
                                  : status == "Sales Order"
                                      ? const Color.fromARGB(255, 238, 181, 95)
                                      : status == "Locked"
                                          ? const Color.fromARGB(
                                              255, 72, 170, 85)
                                          : const Color.fromARGB(
                                              255, 217, 110, 103),
                        ),
                        height: 26,
                        child: Center(
                          child: Text(
                            toTitleCase(status),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: status == "Quotation"
                                        ? const Color.fromARGB(255, 84, 84, 84)
                                        : status == "Quotation Sent"
                                            ? const Color.fromARGB(
                                                255, 22, 93, 150)
                                            : status == "Sales Order"
                                                ? const Color.fromARGB(
                                                    255, 150, 101, 28)
                                                : status == "Locked"
                                                    ? const Color.fromARGB(
                                                        255, 7, 121, 34)
                                                    : const Color.fromARGB(
                                                        255, 115, 17, 10)),
                          ),
                        ),
                      )
                  ],
                ),
              ],
            ),
            if (SizerUtil.deviceType == DeviceType.tablet)
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: status == "draft"
                      ? const Color.fromARGB(255, 199, 198, 198)
                      : status == "sent"
                          ? const Color.fromARGB(255, 113, 187, 247)
                          : status == "sale"
                              ? const Color.fromARGB(255, 238, 181, 95)
                              : status == "done"
                                  ? const Color.fromARGB(255, 72, 170, 85)
                                  : const Color.fromARGB(255, 227, 79, 69),
                ),
                height: 35,
                child: Center(
                  child: Text(
                    status,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: status == "draft"
                              ? const Color.fromARGB(255, 84, 84, 84)
                              : status == "sent"
                                  ? const Color.fromARGB(255, 22, 93, 150)
                                  : status == "sale"
                                      ? const Color.fromARGB(255, 150, 101, 28)
                                      : status == "done"
                                          ? const Color.fromARGB(
                                              255, 7, 121, 34)
                                          : const Color.fromARGB(
                                              255, 115, 17, 10),
                        ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
