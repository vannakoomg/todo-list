import 'package:flutter/material.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';

class CustomTextfiled extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function onChanged;
  final int maxLines;
  const CustomTextfiled({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
      onChanged: (value) {
        onChanged(value);
      },
      decoration: InputDecoration(
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.secondnaryColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColor.secondnaryColor,
          ),
        ),
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
      maxLines: maxLines,
    );
  }
}
