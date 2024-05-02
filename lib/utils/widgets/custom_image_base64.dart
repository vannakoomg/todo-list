import 'dart:convert';

import 'package:flutter/material.dart';

class CustomImageBase64 extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final int borderRadius;
  const CustomImageBase64({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    this.borderRadius = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(100),
        image: image != ""
            ? DecorationImage(
                image: MemoryImage(
                  base64Decode(image),
                ),
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }
}
