import 'package:flutter/material.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';

class CustomTodoCard extends StatelessWidget {
  final String title;
  final String stuts;
  final String distance;
  const CustomTodoCard(
      {super.key,
      required this.stuts,
      required this.title,
      required this.distance});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      height: 60,
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
              color: stuts == "" ? AppColor.dangerColor : AppColor.successColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onTertiary,
                        ),
                  ),
                  Text(
                    distance,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  )
                ],
              ),
            ),
            Icon(
              Icons.keyboard_double_arrow_right,
              color: stuts == "" ? AppColor.dangerColor : AppColor.successColor,
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
