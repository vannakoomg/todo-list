import 'package:flutter/material.dart';

class CustomEmpty extends StatelessWidget {
  const CustomEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "No Data",
        ),
        // Icon(Icons.data)
      ],
    );
  }
}
