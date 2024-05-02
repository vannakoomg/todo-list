import 'package:flutter/material.dart';

class CustomSearchSelect extends StatelessWidget {
  final int index;
  final String title;
  const CustomSearchSelect(
      {super.key, required this.index, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: index % 2 != 0
            ? const Color.fromARGB(255, 117, 178, 144)
            : const Color.fromARGB(255, 241, 206, 154),
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black54),
      ),
    );
  }
}
