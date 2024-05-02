import 'package:flutter/material.dart';

class CustomAddToCard extends StatelessWidget {
  final int number;
  final Function ontap1;
  final Function ontap2;
  const CustomAddToCard({
    super.key,
    required this.number,
    required this.ontap1,
    required this.ontap2,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: 60,
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            // color: Theme.of(context).colorScheme.onSecondary,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                ontap1();
              },
              child: Container(
                  color: Colors.transparent,
                  height: 20,
                  width: 25,
                  child: const Center(child: Text("-"))),
            ),
            Text(
              "$number",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            GestureDetector(
              onTap: () {
                ontap2();
              },
              child: Container(
                color: Colors.transparent,
                height: 20,
                width: 25,
                child: const Center(
                  child: Text("+"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
