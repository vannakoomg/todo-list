import 'package:flutter/material.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';

class CustomOops extends StatelessWidget {
  final Function ontap;
  const CustomOops({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "OOPS !",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary, fontSize: 25),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "SOMETHING WENT WRONG PLEASE ",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSecondary),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomButtom(
          white: 100,
          height: 35,
          title: "TRY AGAIN !",
          fountSize: 12.5,
          onTap: () {
            ontap();
          },
        )
      ],
    );
  }
}
