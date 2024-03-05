import 'package:flutter/material.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';

class CustomButtom extends StatelessWidget {
  final String? title;
  final Function? onTap;
  final bool disble;
  final double fountSize;
  final double height;
  final double white;
  final Color colors;
  final Color textColors;
  final Color borderColor;
  const CustomButtom({
    super.key,
    required this.title,
    required this.onTap,
    this.height = 40,
    this.white = 80,
    this.textColors = Colors.white,
    this.colors = const Color(0xff208b3a),
    this.borderColor = Colors.transparent,
    this.disble = false,
    this.fountSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        disble == false ? onTap!() : null;
      },
      child: AnimatedContainer(
        width: white,
        decoration: BoxDecoration(
          color: disble == false ? colors : AppColor.textThird,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
          ),
        ),
        height: height,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 150),
        child: Center(
          child: Text(
            "$title",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: textColors, fontSize: fountSize),
          ),
        ),
      ),
    );
  }
}
