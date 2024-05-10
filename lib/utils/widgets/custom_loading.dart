import 'package:flutter/material.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoading extends StatelessWidget {
  final Color? colors;
  const CustomLoading({super.key, this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Center(
          child: LoadingAnimationWidget.fourRotatingDots(
        color: AppColor.secondnaryColor,
        size: 40,
      )),
    );
  }
}
