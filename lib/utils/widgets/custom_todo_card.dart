import 'package:flutter/material.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';

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
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 180, 180, 180).withOpacity(0.5),
            spreadRadius: 0.8,
            blurRadius: 8,
            offset: const Offset(1, -1), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Row(
          children: [
            Container(
              width: 9,
              color: stuts == "todo"
                  ? Colors.grey
                  : stuts == "check-in"
                      ? Colors.blue
                      : stuts == "check-out"
                          ? const Color.fromARGB(255, 237, 156, 34)
                          : AppColor.successColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Shop           : ",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onTertiary,
                            ),
                      ),
                      Expanded(
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Customer   : ",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      Expanded(
                        child: Text(
                          customer,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Address      : ",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      Expanded(
                        child: Text(
                          address,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Icon(
              Icons.keyboard_double_arrow_right,
              color: stuts == "todo"
                  ? Colors.grey
                  : stuts == "check-in"
                      ? Colors.blue
                      : stuts == "check-out"
                          ? const Color.fromARGB(255, 237, 156, 34)
                          : AppColor.successColor,
            ),
            const SizedBox(
              width: 5,
            )
          ],
        ),
      ),
    );
  }
}
