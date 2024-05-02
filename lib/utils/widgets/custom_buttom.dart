import 'package:flutter/material.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';

class CustomButtom extends StatelessWidget {
  final String? title;
  final Function? onTap;
  final bool disble;
  final double fountSize;
  final double height;
  final double white;
  final Color? colors;
  final Color textColors;
  final Color borderColor;
  final bool outline;
  final double radius;
  final IconData? icon;
  const CustomButtom({
    super.key,
    required this.title,
    required this.onTap,
    this.height = 40,
    this.radius = 10,
    this.white = 80,
    this.outline = false,
    this.icon,
    this.textColors = Colors.white,
    this.colors,
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
          color: outline == false
              ? disble == true
                  ? Theme.of(context).colorScheme.onSecondary
                  : colors ?? AppColor.secondnaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(
            radius,
          ),
          border: Border.all(
            color: outline == false
                ? borderColor
                : colors ?? AppColor.secondnaryColor,
          ),
        ),
        height: height,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 150),
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  color: Colors.white,
                  size: 19,
                )
              : Text(
                  "$title",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: outline == false
                            ? textColors
                            : colors ?? AppColor.secondnaryColor,
                        fontSize: fountSize,
                      ),
                ),
        ),
      ),
    );
  }
}
